const { copy } = require('copy-text-into-clipboard');
const express = require("express");
const fs = require("fs");
const path = require('path');

const app = express();
const workspaceDir = path.join(__dirname, 'workspace');

if (!fs.existsSync(workspaceDir)) {
    fs.mkdirSync(workspaceDir, { recursive: true });
}

app.use(express.json());

app.get('/readfile', (req, res) => {
    const filePath = path.join(workspaceDir, req.query.path);
    if (fs.existsSync(filePath)) {
        try {
            let fileData = fs.readFileSync(filePath, 'utf8');
            res.send(fileData);
        } catch (err) {
            res.status(500).send("Error reading file.");
            console.error(`Error reading file ${filePath}:`, err);
        }
    } else {
        res.status(404).send("File not found.");
        console.log("Couldn't find file " + filePath);
    }
});

app.get('/writefile', (req, res) => {
    const filePath = path.join(workspaceDir, req.query.path);
    const dirPath = path.dirname(filePath);
    
    try {
        if (!fs.existsSync(dirPath)) {
            fs.mkdirSync(dirPath, { recursive: true });
        }
        
        fs.writeFileSync(filePath, req.query.data);
        res.send("Wrote file to path: " + req.query.path);
    } catch (err) {
        res.status(500).send("Error writing file.");
        console.error(`Error writing file ${filePath}:`, err);
    }
});

app.get('/appendfile', (req, res) => {
    const filePath = path.join(workspaceDir, req.query.path);
    const dirPath = path.dirname(filePath);
    
    try {
        if (!fs.existsSync(dirPath)) {
            fs.mkdirSync(dirPath, { recursive: true });
        }

        fs.appendFileSync(filePath, req.query.data);
        res.send("Appended file to path: " + req.query.path);
    } catch (err) {
        res.status(500).send("Error appending file.");
        console.error(`Error appending file ${filePath}:`, err);
    }
});

app.get('/setclipboard', (req, res) => {
    if (!req.query.text) {
        return res.status(400).send("Text must be provided in the request body.");
    }

    try {
        copy(req.query.text);
        res.send("Text copied: " + req.query.text);
    } catch (err) {
        res.status(500).send("Error copying text.");
        console.error("Error copying text:", err);
    }
});

app.listen(8000, () => {
    console.log(`Server listening on port 8000. Press Ctrl+C to exit.`);
});
