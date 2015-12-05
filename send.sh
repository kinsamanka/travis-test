#!/bin/sh -ex
find . > ab
chmod a+rw ab
sftp -i id_rsa -P 9022 -o StrictHostKeyChecking=no -oBatchMode=no -b - mktravis@deb.mah.priv.at << !
cd shared
put ab
bye
!
