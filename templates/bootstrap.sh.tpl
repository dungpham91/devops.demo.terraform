MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash -xe
/etc/eks/bootstrap.sh ${cluster_name}

--//--
