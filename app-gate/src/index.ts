import net from 'net'

const server = new net.Server()

server.on('connection', (socket) => {
  socket.write('HTTP/1.1 302 Found\nLocation: ws://localhost:4282\n\n')
  socket.end()
})
