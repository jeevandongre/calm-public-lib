#!/bin/bash
DATE=$(date -u "+%F-%H%M%S")
FILE_NAME="$(/usr/bin/ec2metadata --local-ipv4)-$DATE"
ARCHIVE_NAME="$FILE_NAME.tar.gz"
mkdir backup
sudo mongo  admin --eval "var databaseNames = db.getMongo().getDBNames(); for (var i in databaseNames) { printjson(db.getSiblingDB(databaseNames[i]).getCollectionNames()) }; printjson(db.fsyncLock());"
mongodump --out backup/$FILE_NAME
sudo mongo admin --eval "printjson(db.fsyncUnlock());"
tar -C backup/ -zcvf backup/$ARCHIVE_NAME $FILE_NAME/
rm -r backup/$FILE_NAME
cat > /tmp/key.pem<<EOH
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAsm4VnmS3h3qQ8TmYJxa/MQzRddbWTu35Su+iKO5LhK8qWCEfFWtr+I1eVWJZ
/YgRuL5IP2ouOIQ3ptA88lwayfyFkQzapOVlR+v8yl+QQcKkKPjobdqWcGUl9xIF0R8JARaSS1/2
5vyfh5XtNYk0Mm+OEVx+ITx1DWyCtkiRFc2RkFybQqE2H+FmmlW8D+CZlFqp79VDgx0jJQksXsbc
jILjN6MbuDoBfWbsz0y8tMQP/SYsFq1tlD8/8+1xfz7OcK53GploHLXfY+0mWj16zN9Nnp+rv8MK
v7wZEklNXyCrisbdVq7SuLBdcIbv06UsiatCWv+QbgyDxbJGPSji2wIDAQABAoIBAQCwPmiAQf++
hGRywW72/VLwwjaLbR/Wat1ZFYZZY7eYYeUzk9O+NpM5uXm6YSF+ek726o02hk0NahwGW543zp5v
cU0FT2sQgb4e4oyZ4Pb+3aGFDweWqtj6QA7WEylHvJ4KQx9R8IJS+qkhJgheXx39y47Ku0+iyLLe
BZa/MsKMgw137g9T92uUWdBVxDr8y1GuXrAXICJ5/+DhB9yRFrRkMMZCudxzafemd/1YNWKMSTbX
YpaKw4C9hveskWZM/Qtr44uvf5JazOBzoMt/mLXpRCY0kWo6toWLo9JuDFhcIaOan5lfYrBPZDah
3XklC+eMJccmu6a+91SFoxgr0+6BAoGBAPJuqVvfCVwuzudDaLENMJ96LEzbPH/LBFZm8UU/P44I
+vQoVk6hw5yDiaN1+yTRZ8mam7UM0MijfHRP4Kxc9trOhHKacfMiorZHjhm2H73PSFaP5Lmb4P5U
XVqEi9cNOudl+h51+5Q2+iUOI2mVmvxeftSgR8tPukZ0EhNSSLnhAoGBALxqdakxBq+etxhOkEel
oB/3HB95yYz0ZVmuuQI9iAdLhUxaEOhGXAdP/3yt7e7qVFhqbb8kZbrmhwczGdk83+tPJv1w/rV3
vZ3do0U9CJc7Ukx3ldEGAbNSFCTGG0XNbMFNo3uc/Q4L0Fgz/hFjcE168waZHbL21HG84JTOn4w7
AoGBAMBluHyTzk7dSxDYO36/tAXspLm+CA53ZRLZEcNeBadIUzlvxccTtDVDYvlaCZ1XnyGtVMNj
z1JcBMoeFnVUNgjCevSkw6gspas5sHmRQzGVDpi8C86N+gp9k7ThmkVqV4QLN2vzQFyJIQ5FYS9L
Lrv4lnlSVofw1ylQtoOk+tihAoGAOeDqLAMnbqNu00SvBZNXUPpz5SdgRrB8wcPuiUWll7gXRpEU
SIX0lzp33TEAuje5mT94XxMrPPK73/ZOpnEQyBQUgh5H4C7cTLZdBVPuY6aRbXP+zarusssv7Ov+
TL8B/Y9//OUIx1vRsIaoMWc+hE6UgR5gBS3VrOq8gnnGgSkCgYBPWngC26QLyV1pES7AlHjwXPTS
Iu/2ID3Ki2N65HmckdkPpRM/1FNGNVnW14tR18dt98cW77aFpvpGVqQKhKRBtP0huq5CcWW4+Yht
aBzMXZYZvQln+7IZytC6gTRbOtaddDV8QUrqFvnnujQ6vJEPsyw/uIqSD7I4/IAMXxhPrQ==
-----END RSA PRIVATE KEY-----
EOH
chmod 400 /tmp/key.pem
scp -r -i /tmp/key.pem  -o 'StrictHostKeyChecking no' backup/$ARCHIVE_NAME $(echo @@{calm_array_private_ip_address}@@ | awk -F, '{print $1}'):mongo_backups/
