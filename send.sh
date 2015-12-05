#!/bin/sh -ex
find . > ab
chmod a+rw ab
sftp -i ~/access_key -P 9022 -o StrictHostKeyChecking=no -oBatchMode=no -b - travis@deb.mah.priv.at << !
cd shared
put ab
bye
!
