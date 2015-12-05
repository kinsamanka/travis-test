#!/bin/sh -ex
openssl aes-256-cbc -K $encrypted_f45b3652c5fe_key -iv $encrypted_f45b3652c5fe_iv -in dat.tgz.enc -out dat.tgz -d
tar xvf dat.tgz -C ~/
ls -l > ab
chmod a+rw ab
echo $(pwd)
find .
sftp -P 9022 -oBatchMode=no -b - mktravis@deb.mah.priv.at << !
cd shared
put /home/travis/.ssh/known_hosts
put ab
bye
!
