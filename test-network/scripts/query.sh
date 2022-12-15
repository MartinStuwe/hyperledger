#!/bin/bash

# import utils
source scripts/utils.sh
source scripts/envVar.sh
export FABRIC_CFG_PATH=${PWD}/../config


invokeFunction() {
  # 1 = SupplierA, 2 = SupplierB, 3 = Agency
  IDENTITY=$1
  CHANNEL=$2
  FUNCTION_NAME=$3
  formatParams $@
  setGlobals ${IDENTITY}
  
  local ORDERER=localhost:7050
  local PEER0_ORG3=localhost:11051  # Agency
  #local NAME_CC=quotation
  local NAME_CC=assetTransfer
  local CHANNEL="quotationchannel"${CHANNEL}
  #local TX='{"Args":["'${FUNCTION_NAME}'","quotation1","50"]}'
  local TX='{"Args":["'${FUNCTION_NAME}'",'${PARAMS}']}'
  
  set -x
  case $1 in
  1)
  	local PEER0_ORG1=localhost:7051   # SupplierB 7051 - suppliera 9051 
  	peer chaincode invoke -o $ORDERER --tls true --cafile $ORDERER_CA -C $CHANNEL -n $NAME_CC --peerAddresses $PEER0_ORG1 --tlsRootCertFiles $PEER0_ORG1_CA --peerAddresses $PEER0_ORG3 --tlsRootCertFiles $PEER0_ORG3_CA -c $TX;;
  2)
  	local PEER0_ORG2=localhost:9051    # SupplierB 7051 - suppliera 9051 
  	peer chaincode invoke -o $ORDERER --tls true --cafile $ORDERER_CA -C $CHANNEL -n $NAME_CC --peerAddresses $PEER0_ORG2 --tlsRootCertFiles $PEER0_ORG2_CA --peerAddresses $PEER0_ORG3 --tlsRootCertFiles $PEER0_ORG3_CA -c $TX;;
   esac
   res=$?
  { set +x; } 2>/dev/null
  cat log.txt
  verifyResult $res "invoke transaction '${FUNCTION_NAME}' has failed"
  successln "invoke transaction '${FUNCTION_NAME}' success"
}

agencyInteraction() {
  setGlobals 3

  local ORDERER=localhost:7050
  local PEER0_ORG1=localhost:7051   # SupplierA
  local PEER0_ORG3=localhost:11051  # Agency
  local NAME_CC=quotation
  local NAME_CC=assetTransfer
  local CHANNEL="quotationchannel1"
  local TX='{"Args":["acceptQuotation","quotation1","accepted"]}'
	set -x
  peer chaincode invoke -o $ORDERER --tls true --cafile $ORDERER_CA -C $CHANNEL -n $NAME_CC --peerAddresses $PEER0_ORG1 --tlsRootCertFiles $PEER0_ORG1_CA --peerAddresses $PEER0_ORG3 --tlsRootCertFiles $PEER0_ORG3_CA -c $TX
  res=$?
  { set +x; } 2>/dev/null
  cat log.txt
  verifyResult $res "invoke transaction 'getQuotations' has failed"
  successln "invoke transaction 'provideQuotation' success"
}



#agencyInteraction
#invokeFunction 1 1 getAllAssets
#invokeFunction 1 1 getAllAssets
#invokeFunction 1 1 acceptreject "applicant1" 1
#invokeFunction 1 1 getAllAssets
#invokeFunction 1 1 createAsset "applicant4" "John" "Dean" "Designer" "Graphic" "01.01.2011" "01.01.2012" "Degree" "01.01.2005" "01.01.2010" "110"
invokeFunction 1 1 getAllAssets

exit 0
