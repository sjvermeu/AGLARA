#!/bin/sh

if [[ $# -ne 2 ]]
then
  echo "Usage: $0 <zone_domain> <base_dir>"
  echo "";
  echo "Example: $0 genfic.com /mnt/puppet";
  exit 1;
fi

ZONENAME=$1;
BASEDIR=$2;

printf "\$TTL 1h ;\n";
printf "\$ORIGIN ${ZONENAME}.\n";
printf "@	IN	SOA	ns.${ZONENAME}.com. ns.${ZONENAME}.com. (\n";
printf "			$(date '+%Y%m%d%H%M%S')\n";
printf "			1d\n";
printf "			2h\n";
printf "			4w\n";
printf "			1h )\n";
printf "\n";
printf "	IN	NS	ns.${ZONENAME}.\n";
printf "	IN	NS	ns2.${ZONENAME}.\n";
printf "	IN	MX	10	mail.${ZONENAME}.\n";
printf "	IN	MX	20	mail2.${ZONENAME}.\n";
printf "\n";

for NODE in ${BASEDIR}/manifests/nodes/*.pp;
do
  NODENAME=$(basename ${NODE%.pp});
  IP6ADDRESS=$(grep my_ip6address ${NODE} | sed -e 's:.*\"\([0-9a-f\:.]*\)\".*:\1:g');
  printf "${NODENAME}	IN	AAAA	${IP6ADDRESS};\n";
done
