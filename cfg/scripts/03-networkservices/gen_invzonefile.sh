#!/bin/sh

if [[ $# -lt 2 ]]
then
  echo "Usage: $0 <zone_domain> <base_dir> [<reverse>]"
  echo "";
  echo "Example: $0 genfic.com /mnt/puppet";
  echo "         $0 genfic.com /mnt/puppet 1.8.0.0.8.b.d.0.1.0.0.2";
  exit 1;
fi

getReverseAddress() {
  IP6=$1;
  sipcalc ${IP6} | grep Expanded | awk '{print $4}' | rev | sed -e 's|:||g' -e 's|\(.\)|\1.|g';
}

ZONENAME=$1;
BASEDIR=$2;
REVERSE="1.8.0.0.8.b.d.0.1.0.0.2";
if [[ -n "${3}" ]];
then
  REVERSE=$3;
fi

printf "\$TTL 1h ;\n";
printf "@	IN	SOA	${REVERSE}.ip6.arpa ns.${ZONENAME}. (\n";
printf "			$(date '+%Y%m%d%H%M%S')\n";
printf "			1d\n";
printf "			2h\n";
printf "			4w\n";
printf "			1h )\n";
printf "\n";
printf "	IN	NS	ns.${ZONENAME}.\n";
printf "	IN	NS	ns2.${ZONENAME}.\n";
printf "\n";
printf "\$ORIGIN ${REVERSE}.ip6.arpa.\n";
printf "\n";
for NODE in ${BASEDIR}/manifests/nodes/*.pp;
do
  NODENAME=$(basename ${NODE%.pp});
  IP6ADDRESS=$(grep my_ip6address ${NODE} | sed -e 's:.*\"\([0-9a-f\:.]*\)\".*:\1:g');
  REVADDRESS=$(getReverseAddress ${IP6ADDRESS} | sed -e "s:\.${REVERSE}\.::g");
  printf "${REVADDRESS}		IN	PTR	${NODENAME}.${ZONENAME}.\n";
done
