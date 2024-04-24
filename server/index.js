const { getConnection } = require('./rds');
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

app.post('/login', async (req, res) => {
    try {
        const { username, password } = req.body;

        // Validate the input (you can add more validation as needed)
        if (!username || !password) {
            return res.status(400).json({ error: 'Username and password are required' });
        }

        const connection = await getConnection('UserManagement');

        // Query the database to find the user with the provided username
        const [rows] = await connection.execute(
            'SELECT * FROM USER WHERE username = ?',
            [username]
        );

        if (rows.length === 0) {
            // User not found
            connection.end();
            return res.status(401).json({ error: 'Invalid username or password' });
        }

        const user = rows[0];

        // Compare the provided password with the stored password
        if (user.password !== password) {
            // Password doesn't match
            connection.end();
            return res.status(401).json({ error: 'Invalid username or password' });
        }

        // Password matches, login successful
        connection.end();
        res.json({ message: 'Login successful', user });
    } catch (error) {
        console.error('Error executing query:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

app.get('/iot', async (req, res) => {
    try {
        const connection = await getConnection('IotManagement');
        const [rows] = await connection.execute('SELECT * FROM IOT');
        res.json(rows);
        connection.end();
    } catch (error) {
        console.error('Error executing query:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});


app.post('/iot', async (req, res) => {
    const { latitude, longitude, district } = req.body;

    try {
        const connection = await getConnection('IotManagement');

        const query = `
        INSERT INTO IOT (LATITUDE, LONGITUDE, DISTRICT)
        VALUES (?, ?, ?)
      `;

        const [result] = await connection.execute(query, [latitude, longitude, district]);

        const insertedId = result.insertId;

        connection.end();

        res.json({ message: 'IOT device added successfully', iot_id: insertedId });
    } catch (error) {
        console.error('Error adding IOT device:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

app.delete('/iot/:iot_id', async (req, res) => {
    const { iot_id } = req.params;

    try {
        const connection = await getConnection('IotManagement');

        const query = `
        DELETE FROM IOT
        WHERE IOT_ID = ?
      `;

        const [result] = await connection.execute(query, [iot_id]);

        connection.end();

        if (result.affectedRows === 0) {
            res.status(404).json({ error: 'IOT device not found' });
        } else {
            res.json({ message: 'IOT device deleted successfully' });
        }
    } catch (error) {
        console.error('Error deleting IOT device:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});
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
    const video_url = "https:\/\/wzmedia.dot.ca.gov\/D4\/S101_SOF_River_Rd.stream\/playlist.m3u8"

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
const port = 8082;
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});