import axios from 'axios'
import process from 'process'

// eslint-disable-next-line no-process-env
if(!process.env.HEALTH_CHECK_URL) {
  console.log('No health check url specified')
  process.exit(1)
}

// eslint-disable-next-line no-process-env
const retries = process.env.RETRIES ?? 10
// eslint-disable-next-line no-process-env
const healthCheckUrl = process.env.HEALTH_CHECK_URL
// eslint-disable-next-line no-process-env
const timeout = process.env.TIMEOUT ?? 2000

const checkHealth = () => {
  let count = 0

  const quit = (exitCode) => {
    clearTimeout(retryTimeout)
    process.exit(exitCode)
  }

  const retryTimeout = setTimeout(() => {
    if(count++ >= retries) {
      console.log(`Service health check ${healthCheckUrl} not responding after ${count} attempts`)
      quit(1)
    }

    console.log(`Calling health check ${healthCheckUrl} | Attempt ${count}`)

    axios.get(healthCheckUrl)
      .then((response) => {
        let exitCode = 0

        if(response.status !== 200) { exitCode = response.status }

        console.log(`Service health check ${healthCheckUrl} responded with code ${response.status}`)

        quit(exitCode)
      })
      .catch((error) => {
        console.log(`Error calling health check ${healthCheckUrl} | ${error}`)
        quit(1)
      })
  }, timeout)
}

checkHealth()
