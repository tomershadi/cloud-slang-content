#   (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
########################################################################################################
#!!
#! @description: Generates a UUID.
#! @output result: new uuid
#! @result SUCCESS: uuid generated successfully
#!!#
########################################################################################################

namespace: io.cloudslang.base.math

operation:
  name: generate_uuid

  python_action:
    script: |
      import uuid
      new_uuid = str(uuid.uuid1())
  outputs:
    - result: ${new_uuid}
  results:
    - SUCCESS
