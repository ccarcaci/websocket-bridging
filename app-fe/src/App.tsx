import React from 'react'

import './App.css'

const App = (): JSX.Element => {
  const [ messages, setMessages ] = React.useState([] as string[])
  const appendMessage = () => {
    setMessages([ ...messages, 'foobar' ])
    console.log(JSON.stringify(messages))
  }

  return <div className='app-main'>
    <button onClick={appendMessage}>Press Here</button>
  </div>
}

export default App
