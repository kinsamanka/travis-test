#!/bin/sh
yes | sftp -i id_rsa -P 9022 -oBatchMode=no -b - mktravis@deb.mah.priv.at << !
cd shared
put ab
bye
!
