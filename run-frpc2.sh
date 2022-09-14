#!/bin/bash
exec 2>&1
set -euxo pipefail

# when running in CI override the frpc tls files.

if [ -v RUNNER_PASSWORD ]; then
    sudo bash <<EOF
usermod -U $USER
echo "$USER:$RUNNER_PASSWORD" | chpasswd
EOF
fi

./frp/frpc -c frpc2.ini 2>&1 | sed -E 's,[0-9\.]+:6969,***:6969,ig' || true
