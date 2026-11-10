#!/bin/bash

# Funcție care primește 3 parametri: host, IP și server_DNS
verifica_asociere_dns() {
    local nume_host=$1
    local adresa_ip=$2
    local server_dns=$3

    # Folosim dig pentru a cere serverului DNS inregistrarea A (IPv4)
    local resolved_ip=$(dig +short "@$server_dns" "$nume_host" A | tail -n1)

    if [[ "$resolved_ip" == "$adresa_ip" ]]; then
        echo "[OK] Asocierile coincid: $nume_host -> $adresa_ip (verificat via $server_dns)"
    else
        echo "[FAIL] Discrepanță pentru $nume_host: /etc/hosts are $adresa_ip, dar DNS a returnat ${resolved_ip:-NIMIC}"
    fi
}

DNS="8.8.8.8"

while read -r ip host aliases; do
    [[ -z "$ip" || "$ip" == \#* ]] && continue
    
    if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        # Apelul funcției shell cu cei trei parametri necesari
        verifica_asociere_dns "$host" "$ip" "$DNS"
    fi
done < /etc/hosts
