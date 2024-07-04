const express = require('express');
const app = express();
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const editJsonFile = require('edit-json-file');

const storage = multer.diskStorage({
	 destination: (req, file, cb) => {
	 cb(null, __dirname+"/images/")
	},
	filename: (req, file, cb) => {
		const n = Date.now() + "-" +file.originalname;
    cb(null, n);
    let f = editJsonFile(`${__dirname}/image.json`, {autosave : true});
    f.append("path", n);
    f.save();
	},
	});

const uploadStorage = multer({
	storage: storage,
	})
	
app.post('/upload', uploadStorage.single("file"), (req, res) => {
		console.log(req.file);
	
		res.send("Uploaded");
	});

app.get('/', (req, res) => {
	res.send('Hello');
	});
	
app.use('/images', express.static(__dirname+'/images'));

app.get('/data', (req, res) => {
	res.sendFile(__dirname+'/image.json');
	});


app.listen(5000, ()=>console.log('http://localhost:5000/'));
