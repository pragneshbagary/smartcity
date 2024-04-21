const express = require('express');
require('dotenv').config();
const cors = require('cors');
const bodyParser = require('body-parser');
const AWS = require('aws-sdk');
const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, DeleteCommand } = require("@aws-sdk/lib-dynamodb");

const app = express();
app.use(bodyParser.json());
app.use(cors());

// Configure AWS SDK
AWS.config.update({
    region: process.env.AWS_REGION,
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
});

const dynamodb = new AWS.DynamoDB.DocumentClient();
const tableName = 'smartcity';

// Retrieve all cameras
app.get('/cameras', (req, res) => {
    const params = {
        TableName: tableName,
    };

    dynamodb.scan(params, (err, data) => {
        if (err) {
            console.error('Error retrieving cameras:', err);
            res.status(500).json({ error: 'Internal server error' });
        } else {
            res.json(data.Items);
        }
    });
});

// Add a camera
app.post('/cameras', (req, res) => {
    const { coords } = req.body;
    const camera_id = AWS.util.uuid.v4();

    const latitude = parseFloat(coords.lat);
    const longitude = parseFloat(coords.lng);
    const video_url = "example.com"

    const params = {
        TableName: tableName,
        Item: {
            camera_id,
            coords: {
                lat: latitude,
                lng: longitude,
            },
            video_url,
        },
    };

    dynamodb.put(params, (err) => {
        if (err) {
            console.error('Error adding camera:', err);
            res.status(500).json({ error: 'Internal server error' });
        } else {
            res.json({ message: 'Camera added successfully', camera_id });
        }
    });
});


const client2 = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client2);

// Delete a camera
app.delete('/camera/:camera_id', (req, res) => {
    const { camera_id } = req.params;

    const params = {
        TableName: tableName,
        Key: {
            camera_id,
        },
    };

    dynamodb.delete(params, (err) => {
        if (err) {
            console.error('Error deleting camera:', err);
            res.status(500).json({ error: 'Internal server error' });
        } else {
            res.json({ message: 'Camera deleted successfully' });
        }
    });
});

// Start the server
const port = 3000;
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});