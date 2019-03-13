# SafeBoda THE CHALLENGE

## Introduction
SafeBoda want to give out promo codes worth x amount during events so people can get free rides to and from the event. The flaw with that is people can use the promo codes without going for the event. Task: Implement a promo code api with the following features.

* Generation of new promo codes for events

* The promo code is worth a specific amount of ride

* The promo code can expire

* Can be deactivated

* Return active promo codes

* Return all promo codes

* Only valid when user’s pickup or destination is within x radius of the event venue

* The promo code radius should be configurable

* To test the validity of the promo code, expose an endpoint that accept origin, destination, the promo code. The api should return the promo code details and a polyline using the destination and origin if promo code is valid and an error otherwise.

### Clarifications and assumptions:

* To define the radius of coverage of the event, a polygon of four geographical points was defined in the creation of the event,
and in the trip (origin or destination) must be within this polygon to be accepted or rejected.
* The expiration of the promotion is 1 hour after the event.


# Table of contents SafeBoda Exercise
* [Design]
* [Technologies]
* [Install]
* [Test in AWS Amazon]


# Design

## Tables

### Clients

 column         | datatype |
--------------- | -------- |-------------
 last_name      | String   | required
 first_name     | String   | required
 identification | String   | required


### Promotions

 column    | datatype | more
---------- | -------- |-------------
event_id   | integer  | required
client_id  | integer  | required
code       | String   | required
ammount    | float    | required
expiration | datetime | required
state      | boolean  | required | {true is active|false is deactive}

### Events

 column        | datatype | more
-------------- | -------- |-----------
name           | String   | required
poligon_p1_lat | float    | required
poligon_p2_lat | float    | required
poligon_p3_lat | float    | required
poligon_p4_lat | float    | required
poligon_p1_lng | float    | required
poligon_p2_lng | float    | required
poligon_p3_lng | float    | required
poligon_p4_lng | float    | required
location_lat   | float    | required
location_lng   | float    | required
start_event    | datetime | required
end_event      | datetime | required


### Rides

 column              | datatype | more
-------------------- | -------- |-----------
promotion_id         | integer  | required
date                 | datetime | required
ammount              | float    | required
location_initial_lat | float    | required
location_final_lat   | float    | required
location_initial_lng | float    | required
location_final_lng   | float    | required


## Design Most Important Rest API

### Generation of new promo codes for events

```
POST /v1/promotions/
```
request (sample)

{"promotion":{"event_id":1,"client_id":1,"ammount":2000}}

response (sample)

{"data":{"ammount":2.0e3,"code":"JkOL","expiration":"2019-04-13T03:00:00","id":8,"state":true}}

### a promotion can be deactivated

```
PUT /v1/promotions/{n}
```

request (sample)

{"promotion":{"state":false}}

reponse (sample)

{"data":{"ammount":2.0e3,"code":"JkOL","expiration":"2019-04-13T03:00:00","id":8,"state":true}}

### Return active promo codes

```
GET /v1/promotions?state=true
```
response (sample)

{"data":[{"ammount":2.0e3,"code":"JkOL","expiration":"2019-04-13T03:00:00","id":8,"state":true}]}

### Return all promo codes

```
GET /v1/promotions
```

response

{"data":[{"ammount":2.0e3,"code":"JkOL","expiration":"2019-04-13T03:00:00","id":8,"state":true}]}

### To test the validity of the promo code

```
POST /v1/ride
```

* test 1 (validation of radio range)

request (sample)

{"ride":{"promotion_code":1,"origin_lat":13.3986171092087156,"origin_lng":-76.53779983520508,"dest_lat:3.3983600699708756,"dest_lng":-96.55779838562012}}

response (sample)

{"code":501,"message":"the origin or destination must be in the polygon of the event range"}

* test 2 (validation expiration)

request (sample)

{"ride":{"promotion_code":1,"origin_lat":3.3986171092087156,"origin_lng":-76.53779983520508,"dest_lat":3.3983600699708756,"dest_lng":-76.55779838562012}}

response (sample)

{"code":500,"message":"promotion JkOL expired"}

* test 3 (validation success and return poliline)

request (sample)

{"ride":{"promotion_code":1,"origin_lat":3.3986171092087156,"origin_lng":-76.53779983520508,"dest_lat":3.3983600699708756,"dest_lng":-76.55779838562012}}

response (sample)

{"ammount":2.0e3,"id":3,"location_final_lat":3.3983600699708756,"location_final_lng":-76.55779838562012,"location_initial_lat":3.3986171092087156,"location_initial_lng":-76.53779983520508,"poliline":[{"bounds":{"northeast":{"lat":3.3988092,"lng":-76.5378332},"southwest":{"lat":3.3976252,"lng":-76.55744609999999}},"copyrights":"Map data ©2019 Google","legs":[{"distance":{"text":"2.3 km","value":2323},"duration":{"text":"8 mins","value":462},"end_address":"Cl. 1 #66-42, Cali, Valle del Cauca, Colombia","end_location":{"lat":3.3976252,"lng":-76.55744609999999},"start_address":"Cl. 13 #10, Cali, Valle del Cauca, Colombia","start_location":{"lat":3.3986273,"lng":-76.5378332},"steps":[{"distance":{"text":"50 m","value":50},"duration":{"text":"1 min","value":14},"end_location":{"lat":3.3981947,"lng":-76.53796609999999},"html_instructions":"Head <b>south</b> on <b>Cl. 13</b> toward <b>Cra. 66</b>","polyline":{"points":"mxvSlxcrM\\Hx@P"},"start_location":{"lat":3.3986273,"lng":-76.5378332},"travel_mode":"DRIVING"},{"distance":{"text":"2.1 km","value":2064},"duration":{"text":"7 mins","value":422},"end_location":{"lat":3.3987452,"lng":-76.5564582},"html_instructions":"Turn <b>right</b> at the 1st cross street onto <b>Cra. 66</b>","maneuver":"turn-right","polyline":{"points":"uuvShycrMAbBCdB?v@?x@Av@?v@?dCAbC?bB?`B?H?F?V?V?J?HAh@?f@?rB@tB?P?P?~@?~@?Z?Z?bA@JAt@@R?P?H?H?FAF@dA?bA?r@?t@?n@Ap@Ap@Br@?~A?p@?p@ArAArA?X?V?~@A~@@nA@pAE`Dm@vASl@GTCTCX?ZAnKAHAFGL"},"start_location":{"lat":3.3981947,"lng":-76.53796609999999},"travel_mode":"DRIVING"},{"distance":{"text":"0.1 km","value":138},"duration":{"text":"1 min","value":14},"end_location":{"lat":3.3978631,"lng":-76.5568663},"html_instructions":"At the roundabout, take the <b>2nd</b> exit onto <b>Cl. 1</b>","maneuver":"roundabout-right","polyline":{"points":"eyvSzlgrMCBEFAH?F@D@D@BBDB@BBF@D?D?FABADCN?P@TD@?@?D?BA~@V"},"start_location":{"lat":3.3987452,"lng":-76.5564582},"travel_mode":"DRIVING"},{"distance":{"text":"71 m","value":71},"duration":{"text":"1 min","value":12},"end_location":{"lat":3.3976252,"lng":-76.55744609999999},"html_instructions":"Turn <b>right</b><div style=\"font-size:0.9em\">Destination will be on the right</div>","maneuver":"turn-right","polyline":{"points":"ssvSlogrMAB?@?D?B@B@DN^P`@HV"},"start_location":{"lat":3.3978631,"lng":-76.5568663},"travel_mode":"DRIVING"}],"traffic_speed_entry":[],"via_waypoint":[]}],"overview_polyline":{"points":"mxvSlxcrMvAZEhEA`FApOAfB@lG@pI?rFChEBvFCxE@`HE`Dm@vA[bAGn@AjLCPKPGP@LJPJDJ?JCTCj@FHA~@VAB?F@Fl@~A"},"summary":"Cra. 66","warnings":[],"waypoint_order":[]}],"when":"2019-03-13T01:26:44"}

# Technology

* Elixir 1.7.2
* OTP 21.0
* Postgres database

# Install (Development Mode)

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create` and `mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`54.70.207.40:4000`](http://54.70.207.40:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).


# the project deployed in AWS EC2

## Samples test using CURL

### CLIENTS

1. create a new client

```
curl -H "Content-Type: application/json" -X POST -d '{"client":{"last_name":"Erazo Arias", "first_name":"Carlos Mauricio", "identification":"6382404"}}' http://54.70.207.40:4000/v1/clients
```

2. query a client

```
curl -H "Content-Type: application/json" -X GET  http://54.70.207.40:4000/v1/clients/1
```

3. query al clients

```
curl -H "Content-Type: application/json" -X GET  http://54.70.207.40:4000/v1/clients
```

### EVENT

1. create a new event

```
curl -H "Content-Type: application/json" -X POST -d '{"event":{"name":"Event 5ta Cali Colombia", "poligon_p1_lat":-76.55779838562012,"poligon_p2_lat":-76.5420913696289,"poligon_p3_lat":-76.52780055999756,"poligon_p4_lat":-76.54917240142822,"poligon_p1_lng":3.3983600699708756,"poligon_p2_lng":3.397760311482995,"poligon_p3_lng":3.435929909413671,"poligon_p4_lng":3.441284669553734,"location_lat":-76.54325008392334,"location_lng":3.430917826697575,"start_event":"2019-04-12 20:00:10","end_event":"2019-04-13 04:00:00"}}' http://54.70.207.40:4000/v1/events
```

2. query a event

```
curl -H "Content-Type: application/json" -X GET  http://54.70.207.40:4000/v1/events/1
```

3. query all events

```
curl -H "Content-Type: application/json" -X GET  http://54.70.207.40:4000/v1/events
```

### PROMOTION

1. create a new promotion

```
curl -H "Content-Type: application/json" -X POST -d '{"promotion":{"event_id":1,"client_id":1,"ammount":2000}}' http://54.70.207.40:4000/v1/promotions
```

2. deactive promotion

```
curl -H "Content-Type: application/json" -X PUT -d '{"promotion":{"state":true}}' http://54.70.207.40:4000/v1/promotions/8
```

3. Return all promo codes

```
curl -H "Content-Type: application/json" -X GET http://54.70.207.40:4000/v1/promotions
```

4. Return active promo codes

```
curl -H "Content-Type: application/json" -X GET http://54.70.207.40:4000/v1/promotions?state=true
```

### RIDES

take care to capture promotion code automatically generate when the promotion was created and to be sent when validate de ride and promotion

1. To test the validity of the promo code create ride

* (promotion not found)

```
curl -H "Content-Type: application/json" -X POST -d '{"ride":{"promotion_code":"abcd","origin_lat":3.3986171092087156,"origin_lng":-76.53779983520508,"dest_lat":3.3983600699708756,"dest_lng":-76.55779838562012}}' http://54.70.207.40:4000/v1/rides
```

response

{"code":500,"message":"promotion JkOL expired"}

* (promotion found but places not in range of event)

```
curl -H "Content-Type: application/json" -X POST -d '{"ride":{"promotion_code":"JkOL","origin_lat":13.3986171092087156,"origin_lng":-76.53779983520508,"dest_lat":13.3983600699708756,"dest_lng":-96.55779838562012}}' http://54.70.207.40:4000/v1/rides
```

response

{"code":501,"message":"the origin or destination must be in the polygon of the event range"}

* (promotion valid in range and return poliline)

```
curl -H "Content-Type: application/json" -X POST -d '{"ride":{"promotion_code":"JkOL","origin_lat":3.3986171092087156,"origin_lng":-76.53779983520508,"dest_lat":3.3983600699708756,"dest_lng":-76.55779838562012}}' http://54.70.207.40:4000/v1/rides
```

response

{"ammount":2.0e3,"id":3,"location_final_lat":3.3983600699708756,"location_final_lng":-76.55779838562012,"location_initial_lat":3.3986171092087156,"location_initial_lng":-76.53779983520508,"poliline":[{"bounds":{"northeast":{"lat":3.3988092,"lng":-76.5378332},"southwest":{"lat":3.3976252,"lng":-76.55744609999999}},"copyrights":"Map data ©2019 Google","legs":[{"distance":{"text":"2.3 km","value":2323},"duration":{"text":"8 mins","value":462},"end_address":"Cl. 1 #66-42, Cali, Valle del Cauca, Colombia","end_location":{"lat":3.3976252,"lng":-76.55744609999999},"start_address":"Cl. 13 #10, Cali, Valle del Cauca, Colombia","start_location":{"lat":3.3986273,"lng":-76.5378332},"steps":[{"distance":{"text":"50 m","value":50},"duration":{"text":"1 min","value":14},"end_location":{"lat":3.3981947,"lng":-76.53796609999999},"html_instructions":"Head <b>south</b> on <b>Cl. 13</b> toward <b>Cra. 66</b>","polyline":{"points":"mxvSlxcrM\\Hx@P"},"start_location":{"lat":3.3986273,"lng":-76.5378332},"travel_mode":"DRIVING"},{"distance":{"text":"2.1 km","value":2064},"duration":{"text":"7 mins","value":422},"end_location":{"lat":3.3987452,"lng":-76.5564582},"html_instructions":"Turn <b>right</b> at the 1st cross street onto <b>Cra. 66</b>","maneuver":"turn-right","polyline":{"points":"uuvShycrMAbBCdB?v@?x@Av@?v@?dCAbC?bB?`B?H?F?V?V?J?HAh@?f@?rB@tB?P?P?~@?~@?Z?Z?bA@JAt@@R?P?H?H?FAF@dA?bA?r@?t@?n@Ap@Ap@Br@?~A?p@?p@ArAArA?X?V?~@A~@@nA@pAE`Dm@vASl@GTCTCX?ZAnKAHAFGL"},"start_location":{"lat":3.3981947,"lng":-76.53796609999999},"travel_mode":"DRIVING"},{"distance":{"text":"0.1 km","value":138},"duration":{"text":"1 min","value":14},"end_location":{"lat":3.3978631,"lng":-76.5568663},"html_instructions":"At the roundabout, take the <b>2nd</b> exit onto <b>Cl. 1</b>","maneuver":"roundabout-right","polyline":{"points":"eyvSzlgrMCBEFAH?F@D@D@BBDB@BBF@D?D?FABADCN?P@TD@?@?D?BA~@V"},"start_location":{"lat":3.3987452,"lng":-76.5564582},"travel_mode":"DRIVING"},{"distance":{"text":"71 m","value":71},"duration":{"text":"1 min","value":12},"end_location":{"lat":3.3976252,"lng":-76.55744609999999},"html_instructions":"Turn <b>right</b><div style=\"font-size:0.9em\">Destination will be on the right</div>","maneuver":"turn-right","polyline":{"points":"ssvSlogrMAB?@?D?B@B@DN^P`@HV"},"start_location":{"lat":3.3978631,"lng":-76.5568663},"travel_mode":"DRIVING"}],"traffic_speed_entry":[],"via_waypoint":[]}],"overview_polyline":{"points":"mxvSlxcrMvAZEhEA`FApOAfB@lG@pI?rFChEBvFCxE@`HE`Dm@vA[bAGn@AjLCPKPGP@LJPJDJ?JCTCj@FHA~@VAB?F@Fl@~A"},"summary":"Cra. 66","warnings":[],"waypoint_order":[]}],"when":"2019-03-13T01:26:44"}
