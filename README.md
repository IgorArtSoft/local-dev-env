# Microservices Demo: Order Processing with Kafka and MongoDB

## Overview

This demo project highlights a simple event-driven microservices architecture using Spring Boot, Kafka, MongoDB, and Docker.

The main business flow starts when a client sends a REST request to create an order. The `order-service` receives the request, creates an `OrderEvent`, and publishes it to a Kafka topic. The `payment-service` consumes that event from Kafka, processes it, and saves the payment-related record into MongoDB.

This demonstrates asynchronous communication between microservices using Kafka.

---

## High-Level Architecture

The system contains three main parts:

1. **order-service**
   - Exposes a REST API.
   - Accepts new order requests.
   - Publishes order events to Kafka.

2. **Kafka**
   - Acts as the event streaming platform.
   - Stores and delivers messages between services.
   - Decouples `order-service` from `payment-service`.

3. **payment-service**
   - Listens to the Kafka topic.
   - Consumes `OrderEvent` messages.
   - Saves payment records into MongoDB.

4. **MongoDB**
   - Stores order/payment data.
   - `orderdb` is used by `order-service`.
   - `paymentdb` is used by `payment-service`.

---

## Data Flow

```mermaid
flowchart TD
    A[REST Client] -->|POST /orders| B[order-service]

    subgraph ORDER_SERVICE[order-service]
        B --> C[OrderController]
        C --> D[OrderService]
        D --> E[Create OrderEvent]
        E --> F[Kafka Producer]
    end

    F -->|Publish message| G[(Kafka Topic: orders)]

    G -->|Consume message| H[Kafka Listener]

    subgraph PAYMENT_SERVICE[payment-service]
        H --> I[PaymentService]
        I --> J[Create Payment Document]
        J --> K[PaymentRepository]
    end

    K --> L[(MongoDB: paymentdb)]
    L --> M[(Collection: payments)]