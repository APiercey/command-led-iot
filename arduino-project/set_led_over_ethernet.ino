#include <Ethernet.h>
#include <MQTT.h>
#include <ArduinoJson.h>

static const int LED_PIN = 9;
static const char NODE_NAME[] = "test_node";
static byte mac[] = {0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED};
const char BROKER_ADDRESS[] = "161.35.27.166";
char COMMAND_TOPIC[] = "command";
char PUBLISH_TOPIC[] = "data";
static bool hasPublishedChanges = false;
static int luminosity = 100;

EthernetClient net;
MQTTClient mqttClient;
StaticJsonDocument<29> doc;

void setup() {
  Serial.begin(9600);
  Ethernet.begin(mac);

  mqttClient.begin(BROKER_ADDRESS, net);
  mqttClient.onMessageAdvanced(onMessage);

  connectToBroker();
}

void loop() {
  mqttClient.loop();

  connectToBroker();

  setLuminosityOnLED();

  publishChanges();
}

void onMessage(MQTTClient *client, char topic[], char payload[], int payload_length) {
  Serial.println(payload);

  DeserializationError err = deserializeJson(doc, payload);

  if(err) {
    Serial.println("deserializeJson() failed with code");
    return;
  }

  luminosity = doc["luminosity"];
  hasPublishedChanges = false;
}

void publishChanges() {
  if(!hasPublishedChanges) {
    char message[14];
    
    sprintf(message, "luminosity=%d", luminosity);
    mqttClient.publish(PUBLISH_TOPIC, message);  
    Serial.println("Sent updates!");
    
    hasPublishedChanges = true;
  }
}

void connectToBroker() {
  if(mqttClient.connected()) {
    return;
  }
  
  Serial.print("Connecting to broker");
  
  while (!mqttClient.connect(NODE_NAME, "try", "try")) {
    Serial.print(".");
    delay(1000);
  }
  
  Serial.println("Connected!");
  Serial.println("Subscribing to command topic");

  if(mqttClient.subscribe(COMMAND_TOPIC)) {
    Serial.println("Subscribed successfully!");  
  } else {
    Serial.println("Subscription error for command topic");
  }
}

void setLuminosityOnLED() {
  analogWrite(LED_PIN, luminosity);
}
