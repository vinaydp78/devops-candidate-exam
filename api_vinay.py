const https = require('https')

exports.handler = async function () {
  const res = await fetch(https://2xfhzfbt31.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data')
  const randomFact = JSON.parse(res).value

  return randomFact
}

async function fetch(url) {
  return new Promise((resolve, reject) => {
    const request = https.get(url, { timeout: 1000 }, (res) => {
      if (res.statusCode < 200 || res.statusCode > 299) {
        return reject(new Error(`HTTP status code ${res.statusCode}`))
      }

      const body = []
      res.on('data', (chunk) => body.push(chunk))
      res.on('end', () => {
        const resString = Buffer.concat(body).toString()
        resolve(resString)
      })
    })

    request.on('error', (err) => reject(err))
    request.on('timeout', (err) => {
      console.log('timed out', err)
      reject(err)
    })
  })
}
