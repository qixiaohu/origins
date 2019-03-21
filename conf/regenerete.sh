rm -rf ./channel-artifacts/*
rm -rf ./crypto-config/*

cryptogen generate --config=./crypto-config.yaml

# 生成创始块文件
echo "---------------- Create genesis.block file BEGIN --------------------"
configtxgen -profile ThreeOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block
echo "---------------- Create genesis.block file END --------------------"

# 生成 unionchannel 文件
echo "---------------- Create unionchannel.tx file BEGIN -------------------"
configtxgen -profile unionOrgschannel -outputCreateChannelTx ./channel-artifacts/unionchannel.tx -channelID unionchannel
echo "---------------- Create unionchannel.tx file END -------------------"

# 生成 fgjchannel
echo "---------------- Create fgjchannel.tx file BEGIN -------------------"
configtxgen -profile fgjOrgchannel -outputCreateChannelTx ./channel-artifacts/fgjchannel.tx -channelID fgjchannel
echo "---------------- Create fgjchannel.tx file END -------------------"

# 生成 tgjchannel
echo "---------------- Create tgjchannel.tx file BEGIN -------------------"
configtxgen -profile tgjOrgchannel -outputCreateChannelTx ./channel-artifacts/tgjchannel.tx -channelID tgjchannel
echo "---------------- Create tgjchannel.tx file END -------------------"

# 生成 tgjchannel
echo "---------------- Create zfptchannel.tx file BEGIN -------------------"
configtxgen -profile zfptOrgchannel -outputCreateChannelTx ./channel-artifacts/zfptchannel.tx -channelID zfptchannel
echo "---------------- Create zfptchannel.tx file END -------------------"

echo "----------------------------------------------------"
configtxgen -profile unionOrgschannel -outputAnchorPeersUpdate ./channel-artifacts/OfgjMSPanchors.tx -channelID unionchannel -asOrg OfgjMSP
echo "----------------------------------------------------"
configtxgen -profile unionOrgschannel -outputAnchorPeersUpdate ./channel-artifacts/OtgjMSPanchors.tx -channelID unionchannel -asOrg OtgjMSP
echo "----------------------------------------------------"
configtxgen -profile unionOrgschannel -outputAnchorPeersUpdate ./channel-artifacts/OzfptMSPanchors.tx -channelID unionchannel -asOrg OzfptMSP
