#   (c) Copyright 2015 Hewlett-Packard Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
####################################################
#!!
#! @description: Main flow to call to release a floating IP.
#! @input token: auth token obtained by get_authenication_flow
#! @input region: HP Cloud region; 'a' or 'b'  (US West or US East)
#! @input proxy_host: optional - proxy server used to access the web site
#! @input proxy_port: optional - proxy server port
#! @output return_result: JSON listing all floating IP and details
#! @output error_message: message returned when HTTP call fails
#! @output status_code: normal status code is 200
#! @result SUCCESS: operation succeeded
#! @result FAILURE: otherwise
#!!#
####################################################

namespace: io.cloudslang.hp_cloud.net

imports:
  rest: io.cloudslang.base.http

flow:
  name: list_all_floating_ips
  inputs:
    - token:
        sensitive: true
    - region
    - proxy_host:
        required: false
    - proxy_port:
        required: false

  workflow:
    - rest_list_all_floating_ips:
        do:
          rest.http_client_get:
            - url: ${'https://region-' + region + '.geo-1.network.hpcloudsvc.com/v2.0/floatingips'}
            - headers: ${'X-AUTH-TOKEN:' + token}
            - content_type: 'application/json'
            - proxy_host
            - proxy_port
        publish:
          - return_result
          - error_message
          - status_code

  outputs:
    - return_result
    - error_message
    - status_code
