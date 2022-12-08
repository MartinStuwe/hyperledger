'use strict';

const { Contract } = require('fabric-contract-api')

class AssetTransfer extends Contract {

    async initLedger(ctx) {
       
        }
    

    // CreateAsset issues a new asset to the world state with given details.
    async CreateAsset(ctx, id, color, size, owner, appraisedValue) {
        
    }



    // UpdateAsset updates an existing asset in the world state with provided parameters.
    async UpdateAsset(ctx, id, color, size, owner, appraisedValue) {
	
    }

    // DeleteAsset deletes an given asset from the world state.
    async DeleteAsset(ctx, id) {
        
    }



    // TransferAsset updates the owner field of asset with given id in the world state.
    async TransferAsset(ctx, id, newOwner) {
       
    }

    // GetAllAssets returns all assets found in the world state.
    async GetAllAssets(ctx) {
        
    }

}

module.exports = AssetTransfer
