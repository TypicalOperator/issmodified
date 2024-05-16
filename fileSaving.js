const { copy } = require('copy-text-into-clipboard');
const express = require("express");
const fs = require("fs");

const app = express();

app.use(express.json());

app.get('/readfile', (req, res) => {
    let fileData = fs.readFileSync("workspace/" + req.query.path);
    res.send(fileData);
});

app.get('/writefile', (req, res) => {
    fs.writeFileSync("workspace/" + req.query.path, req.query.data);
    res.send("Wrote file to path: " + req.query.path);
});

app.get('/appendfile', (req, res) => {
    fs.appendFileSync('workspace/' + req.query.path, req.query.data);
    res.send("Appended file to path: " + req.query.path);
});

app.get('/setclipboard', (req, res) => {
    if (!req.query.text) {
        return res.status(400).send("Text must be provided in the request body.");
    }

    copy(req.query.text);
    res.send("Text copied: " + req.query.text);
});

app.listen(8000, () => {
    console.log(`Server listening on port 8000. Press Ctrl+C to exit.`);
});
