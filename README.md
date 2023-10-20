<p style="font-size:14px" align="right">
<a href="https://t.me/autosultan_group" target="_blank">Join our telegram <img src="https://user-images.githubusercontent.com/50621007/183283867-56b4d69f-bc6e-4939-b00a-72aa019d1aea.png" width="30"/></a>
</p>
<p align="center">
  <img height="400" height="auto" src="https://user-images.githubusercontent.com/109174478/209359981-dc19b4bf-854d-4a2a-b803-2547a7fa43f2.jpg">
</p>

# TUTORIAL ENTANGLE NODE
## SOSMED
- [Twitter](https://twitter.com/Entanglefi)
- [Discord](https://discord.gg/entanglefi)
- [Doc](https://entangle-protocol.gitbook.io/entangle-protocol/validator-guidelines-technical)
- [Website](https://test.entangle.fi/)

## SPEK VPS

|  Komponen |  Minimum |
| ------------ | ------------ |
| CPU  | 2CPU cores  |
| RAM | 8GB RAM |
| Storage  | 200GB |
| Bandwidth | 10mbps |

## Install Package
```
wget -O entangle.sh https://raw.githubusercontent.com/sipalingnode/entangle/main/entangle.sh; chmod +x entangle.sh; ./entangle.sh
```
## Konfigurasi Node
```
sudo rm -rf /usr/local/go
curl -Ls https://go.dev/dl/go1.21.3.linux-amd64.tar.gz | sudo tar -xzf - -C /usr/local
eval $(echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee /etc/profile.d/golang.sh)
eval $(echo 'export PATH=$PATH:$HOME/go/bin' | tee -a $HOME/.profile)
```
```
cd entangle-blockchain
```
```
make install
```
## Create Wallet & Backup
```
entangled keys add wallet
```
**Keterangan : Yang ane tandain itu Phrase kalian simpan jangan sampe hilang**
<p align="center">
  <img height="400" height="auto" src="https://user-images.githubusercontent.com/109174478/276370372-2fd201a4-384e-46a5-b3de-996a4d29b5fb.jpg">
</p>

```
entangled keys unsafe-export-eth-key wallet
```
**Keterangan : Import private key ke metamask wallet dan claim faucet di discord**
<p align="center">
  <img height="200" height="auto" src="https://user-images.githubusercontent.com/109174478/276369960-3a2e24b8-40cc-4dc9-954f-ef676263a4f9.jpg">
</p>

## Setting Node
```
entangled init YourNAME --chain-id entangle_33133-1
entangled config chain-id entangle_33133-1
```
```
cp -f config/genesis.json $HOME/.entangled/config/
cp -f config/config.toml $HOME/.entangled/config/
```
```
sudo tee /etc/systemd/system/entangle.service > /dev/null << EOF
[Unit]
Description=Entangle Validator
Requires=network-online.target
After=network-online.target


[Service]
Type=exec
User=$USER
ExecStart=$(which entangled) start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```
## Download Snapshoot From [STAVR](https://github.com/obajay/nodes-Guides/tree/main/Projects/Entangle#snapshot-testnet-07gb-archive-snapshot)
```
cd $HOME
sudo systemctl stop entangle
sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1false|" ~/.entangled/config/config.toml
cp $HOME/.entangled/data/priv_validator_state.json $HOME/.entangled/priv_validator_state.json.backup
rm -rf $HOME/.entangled/data
curl -o - -L https://entangle.snapshot.stavr.tech/entagle/entagle-snap.tar.lz4 | lz4 -c -d - | tar -x -C $HOME/.entangled --strip-components 2
mv $HOME/.entangled/priv_validator_state.json.backup $HOME/.entangled/data/priv_validator_state.json
wget -O $HOME/.entangled/config/addrbook.json "https://raw.githubusercontent.com/obajay/nodes-Guides/main/Projects/Entangle/addrbook.json"
sudo systemctl restart entangle
```
## Running Node
```
sudo systemctl daemon-reload
sudo systemctl enable entangle.service
sudo systemctl start entangle.service && sudo journalctl -fu entangle -o cat
```
<p align="center">
  <img height="400" height="auto" src="https://user-images.githubusercontent.com/109174478/276374548-8a4b2366-b493-4d0d-8f0b-b1dab42bc9ae.png">
</p>

**Keterangan : Kalo udah jalan kek gini langsung `CTRL+C` aja kgk apa2 tinggal nunggu sinkron**

## Create Validator (Jika sudah sinkron)
- Cek Status Sinkron
  ```
  entangled status 2>&1 | jq .SyncInfo
  ```
- Create Validator
 ```
entangled tx staking create-validator \
--amount="5000000000000000000aNGL" \
--pubkey=$(entangled tendermint show-validator) \
--moniker="YourNAME" \
--chain-id=entangle_33133-1 \
--commission-rate="0.10" \
--identity " " \
--website " " \
--details " " \
--commission-max-rate="0.20" \
--commission-max-change-rate="0.01" \
--min-self-delegation="1" \
--gas=500000 \
--gas-prices="10aNGL" \
--from=wallet
```

## Delete Node (Jika sudah end eventnya)
```
sudo systemctl stop entangle
sudo systemctl disable entangle
rm /etc/systemd/system/entangle.service
sudo systemctl daemon-reload
cd $HOME
rm -rf entangle-blockchain
rm -rf .entangled
rm -rf $(which entangled)
```
