#   (c) Copyright 2016 Hewlett-Packard Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
####################################################
namespace: io.cloudslang.amazon.aws.ec2.volumes

imports:
  volumes: io.cloudslang.amazon.aws.ec2.volumes
  lists: io.cloudslang.base.lists
  strings: io.cloudslang.base.strings

flow:
  name: test_delete_volume_in_region

  inputs:
    - provider: 'amazon'
    - endpoint: 'https://ec2.amazonaws.com'
    - identity:
        default: ''
        required: false
    - credential:
        default: ''
        required: false
    - proxy_host:
        default: ''
        required: false
    - proxy_port:
        default: '8080'
        required: false
    - debug_mode:
        default: 'false'
        required: false
    - region:
        default: 'us-east-1'
        required: false
    - volume_id

  workflow:
    - delete_volume:
        do:
          volumes.delete_volume_in_region:
            - provider
            - endpoint
            - identity
            - credential
            - proxy_host
            - proxy_port
            - debug_mode
            - region
            - volume_id
        publish:
          - return_result
          - return_code
          - exception
        navigate:
          - SUCCESS: check_result
          - FAILURE: DELETE_VOLUME_FAILURE

    - check_result:
        do:
          lists.compare_lists:
            - list_1: ${str(exception) + "," + return_code}
            - list_2: ",0"
        navigate:
          - SUCCESS: check_deletion_message_exist
          - FAILURE: CHECK_RESULT_FAILURE

    - check_deletion_message_exist:
        do:
          strings.string_occurrence_counter:
            - string_in_which_to_search: ${return_result}
            - string_to_find: 'Delete volume process started successfully.'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: CHECK_DELETION_MESSAGE_FAILURE

  results:
    - SUCCESS
    - DELETE_VOLUME_FAILURE
    - CHECK_RESULT_FAILURE
    - CHECK_DELETION_MESSAGE_FAILURE
