#! /bin/bash

CERT_DIR=/home/sapkyy/certificates

if [ ! -f $CERT_DIR/ca_sapkyy_home.key ]; then
  openssl genrsa -out $CERT_DIR/ca_sapkyy_home.key 2048
  echo -e 'RU\n''Udmurt Republic\n''Izhevsk\n''sapkyy\n''sapkyy\n''sapkyy.home\n''sapkyy@gmail.com\n' | openssl req -x509 -new -nodes -key $CERT_DIR/ca_sapkyy_home.key -sha256 -days 9999 -out $CERT_DIR/ca_sapkyy_home.crt 2> /dev/null
fi

SUBJECT="/C=RU/ST=Udmurt Republic/L=Izhevsk/O=sapkyy/CN=sapkyy.home"
NUM_OF_DAYS=999

openssl req -new -newkey rsa:2048 -sha256 -nodes -keyout $CERT_DIR/sapkyy.home.key -subj "$SUBJECT" -out $CERT_DIR/sapkyy.home.csr

openssl x509 -req -in $CERT_DIR/sapkyy.home.csr -CA $CERT_DIR/ca_sapkyy_home.crt -CAkey $CERT_DIR/ca_sapkyy_home.key -CAcreateserial -out $CERT_DIR/sapkyy.home.crt -days $NUM_OF_DAYS -sha256 -extfile sapkyy.home.config
