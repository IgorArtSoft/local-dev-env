$response = Invoke-WebRequest `
  -Uri "http://localhost:8081/orders" `
  -Method Post `
  -ContentType "application/json" `
  -Body '{"orderId":"ORD-1010","customerId":"CUST-1010","amount":32.87}'

$response.StatusCode
$response.Content