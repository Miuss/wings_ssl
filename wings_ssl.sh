echo "正在为节点域名: $0 申请证书";
echo "Ali_Key: $1";
echo "Ali_Secret: $2";
echo "Email: $3";

# 安装 acme.sh
git clone https://github.com/acmesh-official/acme.sh.git
cd acme.sh
./acme.sh --install -m $3

# 添加阿里云accesskey
export Ali_Key="$1"
export Ali_Secret="$2"

source ~/.bashrc

mkdir -p /etc/letsencrypt/live/$0

~/.acme.sh/acme.sh --register-account -m $3

~/.acme.sh/acme.sh --set-default-ca --server zerossl

# 申请证书
~/.acme.sh/acme.sh --issue --dns dns_ali -d $0 --server zerossl --key-file /etc/letsencrypt/live/$0/privkey.pem --fullchain-file /etc/letsencrypt/live/$0/fullchain.pem --dnssleep 1000
