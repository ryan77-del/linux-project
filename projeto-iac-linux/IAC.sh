#!/bin/bash

#DIRETÓRIOS
dir=("publico" "adm" "ven" "sec")

#GRUPOS
grp=("GRP_ADM" "GRP_VEN" "GRP_SEC")

#USUÁRIOS
adm=("carlos" "maria" "joao")
ven=("debora" "sebastiana" "roberto")
sec=("josefina" "amanda" "rogerio")

echo "==================================================================="
echo "Script de Criação de Estrutura de Usuários, Diretórios e Permissões"
echo "==================================================================="

echo "Criando diretórios..."
for d in "${dir[@]}"
do
	mkdir -p /$d
done

echo "Criando grupos..."
for g in "${grp[@]}"
do
	 groupadd $g
done

echo "Criando usuários GRP_ADM..."
for a in "${adm[@]}"
do
	 useradd $a -m -s /bin/bash -p $(openssl passwd -6 senha123) -G GRP_ADM
	 passwd $a -e -q
done

echo "Criando usuários GRP_VEN..."
for v in "${ven[@]}"
do
	useradd $v -m -s /bin/bash -p $(openssl passwd -6 senha123) -G GRP_VEN
	passwd $v -e -q
done

echo "Criando usuários GRP_SEC..."
for s in "${sec[@]}"
do
	useradd $s -m -s /bin/bash -p $(openssl passwd -6 senha123) -G GRP_SEC
	passwd $s -e -q
done

echo "Configurando permissões dos diretórios..."

chown  root:GRP_ADM /adm
chown  root:GRP_VEN /ven
chown  root:GRP_SEC /sec

chmod 770 /adm
chmod 770 /ven
chmod 770 /sec
chmod 777 /publico

echo "Encerrando script..."
