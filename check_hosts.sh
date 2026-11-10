#!/bin/bash
# Iterăm prin liniile din /etc/hosts
while read -r ip host aliases; do
    # Sărim peste liniile goale și comentarii
    [[ -z "$ip" || "$ip" == \#* ]] && continue
    
    # Verificare simplă de format IP
    if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "[Regex] IP valid găsit: $ip pentru host-ul $host"
    fi
done < /etc/hosts
