#NYC Voterfile API
This repository holds the code and documentation for the API that sits atop the
voter file and voter scoring databases used by VoterKarma.  Please see Terms of
Use for limitations on commercial use of the data.

##Single Query Endpoints
The API offers several `GET` endpoints, which serve predominately to serve
single voter responses based upon queries passed through url parameters.
###Parameters
The `GET` endpoints accepts three values: `dob` (`YYYYMMDD`), `lastname`, and `firstname`.
The API strictly applies `dob` and `lastname` to identify unique voters, and
then - if relevant - filters down the results based upon the `firstname`
parameter.  If more than one result remains, the API returns the first result
in that collection.
###Response
The API responds with a JSON string that includes a `success` key indicating
whether the request was successfully handled and a `body` key containing the
informational response.
### /info
The `GET /info` endpoint may be used to get relevant electoral information about
a voter, including their name, NYSBOEID, registration status, party enrollment,
and various electoral districts.

Sample Request:
```
curl -X GET "http://www.voterfile.nyc/info?lastname=chestnut&firstname=william"
```

Sample Response:
```
{
"success":true,
"body":
  {
    "firstname":"WILLIAM",
    "lastname":"CHESTNUT",
    "dob":"1948-03-24",
    "sboeid":"NY000000000038157351",
    "enrollment":"DEM",
    "status":"INACTIVE",
    "idmet":true,
    "election_district":11,
    "legislative_district":null,
    "congressional_district":13,
    "senate_district":30,
    "assembly_district":71,
    "council_district":9
  }
}
```

### /score
The `GET /score` endpoint may be used to retrieve Local, Midterm, Presidential
and Overall Voter Scores for a specific voter.  


Sample Request:
```
curl -X GET "http://www.voterfile.nyc/score?lastname=chestnut&firstname=william"
```

Sample Response:
```
{
  "success":true,
  "body":
    {
      "firstname":"WILLIAM",
      "lastname":"CHESTNUT",
      "dob":"1948-03-24",
      "sboeid":"NY000000000038157351",
      "local_primary":"0.0148568561452",
      "local_general":"0.0119448615791",
      "national_midterm":"0.0125203056982",
      "national_presidential":"0.10249866171",
      "score_w_scaled":"0.0127796093651",
      "score_total_scaled":"0.0431264033605"
    }
}
```
