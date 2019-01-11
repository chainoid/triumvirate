//SPDX-License-Identifier: Apache-2.0

/*
  This code is based on code written by the Hyperledger Fabric community.
  Original code can be found here: https://github.com/hyperledger/fabric-samples/blob/release/fabcar/query.js
  and https://github.com/hyperledger/fabric-samples/blob/release/fabcar/invoke.js
 */

// call the packages we need
var express       = require('express');        // call express
var app           = express();                 // define our app using express
var bodyParser    = require('body-parser');
var http          = require('http')
var fs            = require('fs');
var Fabric_Client = require('fabric-client');
var path          = require('path');
var util          = require('util');
var os            = require('os');


// Ledger utilities
const ledgerUtils  = require("./ledgerUtils.js");


module.exports = (function() {
return{
	get_all_parsels: function(req, res){

		console.log("getting all parsels from ledger: ");
		
		var queryParselListParams = {
			Key: '' // For now we pass a blank string to query all parsels,
			        // TODO : add fromKey, toKey
		};

		var model = GetRecordMapModel(queryParselListParams, 'postap', 'queryAllParsels', 'posta-channel');

		ReadFromLedger(model, res);
	},

	add_parsel: function(req, res){

		console.log(" create new parsel object and put into the ledger: ");
		
		var array = req.params.parsel.split("-");
		console.log(array);

		var sender = array[0]
		var senderBranch = array[1]
		var receiver = array[2]
		var receiverBranch = array[3]

		console.log(array);

		var addParselParams = {
            Sender:       sender,
			SenderBranch: senderBranch,
			Receiver:  receiver,
			ReceiverBranch: receiverBranch
		};

		// Retrieve Blockchain Parameter Mapping Model
    	var model = GetRecordMapModel(addParselParams, 'postap', 'acceptParsel', 'posta-channel');
		
		console.log(" The model before write to the ledger: ",  model);
		
		WriteToLedger(model, res);
	},


	get_parsel: function(req, res){

		console.log(" getting details about parsel: ");

		var key = req.params.id
		
		var queryParselDetailsParams = {
			Key:  key
		};

		var model = GetRecordMapModel(queryParselDetailsParams, 'postap', 'queryParsel', 'posta-channel');

		ReadFromLedger(model, res);
	},

	get_sender: function(req, res){

		console.log(" getting all sent parsels by client: ");

		var name = req.params.name
		console.log(name);
		
		var querySentParselsParams = {
			Key:  name
		};

		var model = GetRecordMapModel(querySentParselsParams, 'postap', 'querySender', 'posta-channel');

		ReadFromLedger(model, res);
	},

    history_parsel: function(req, res){

		console.log("get parsel history: ");

		var historyId = req.params.historyId

		var historytParams = {
			Key:  historyId
		};

		var model = GetRecordMapModel(historytParams, 'postap', 'historyRecord', 'posta-channel');

		ReadFromLedger(model, res);	   
 	},


	delivery_parsel: function(req, res){

		console.log("put a timestamp, changing owner of parsel on delivery: ");

		var array = req.params.parsel.split("-");
		var parselId = array[0]
		
		console.log(array);

		var parsel = {
            ParselId: parselId
       	};

        // Retrieve Blockchain Parameter Mapping Model
		// param(s): record, chaincodeId, chaincodeFunction, channelId
		var model = GetRecordMapModel(parsel, 'postap', 'deliveryParsel', 'posta-channel');
		
		console.log(" The model before write to the ledger: ",  model);
		
		WriteToLedger(model, res);
	}

}
})();
