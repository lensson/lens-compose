const http = require('http');
const hostname = '127.0.0.1';
const port = 8301;
const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello World\n This is in the port 8301');
});
server.listen(port, () => {
    console.log(`服务器运行在 http://${hostname}:${port}/`);
});
