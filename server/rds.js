const mysql = require('mysql2/promise');

const dbConfig = {
  host: 'database-1.cdeoiu8succg.us-east-1.rds.amazonaws.com',
  port: 3306,
  user: 'admin',
  password: 'Admin2024',
};

async function getConnection(dbName) {
  try {
    const connection = await mysql.createConnection({
      ...dbConfig,
      database: dbName,
    });
    return connection;
  } catch (error) {
    console.error('Error connecting to the database:', error);
    throw error;
  }
}

module.exports = { getConnection };