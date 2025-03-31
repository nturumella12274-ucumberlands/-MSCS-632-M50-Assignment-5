"--------------------------------------------------------------------------
 Ride Class
--------------------------------------------------------------------------"
Object subclass: Ride [
    | rideID pickupLocation dropoffLocation distance |

    "Initialize the ride with ID, pickup location, dropoff location, and distance."
    initializeWithID: anID pickup: pickup dropoff: dropoff distance: dist [
        rideID := anID.
        pickupLocation := pickup.
        dropoffLocation := dropoff.
        distance := dist
    ]

    "Abstract method for calculating fare. 
     Subclasses should override this."
    calculateFare [
        self subclassResponsibility
    ]

    "Returns a basic description of the ride details."
    rideDetails [
        ^ 'Ride ID: ', rideID asString,
          ' Pickup: ', pickupLocation,
          ' Dropoff: ', dropoffLocation,
          ' Distance: ', distance asString, ' miles'
    ]
].

"--------------------------------------------------------------------------
 StandardRide Class
--------------------------------------------------------------------------"
Ride subclass: StandardRide [
    "Calculates the fare at $1.50 per mile."
    calculateFare [
        ^ distance * 1.5
    ]

    "Adds fare info to the ride details."
    rideDetails [
        ^ super rideDetails,
          ', Fare: $', self calculateFare asString,
          ' (Standard Rate)'
    ]
].

"--------------------------------------------------------------------------
 PremiumRide Class
--------------------------------------------------------------------------"
Ride subclass: PremiumRide [
    "Calculates the fare at $3.00 per mile."
    calculateFare [
        ^ distance * 3.0
    ]

    "Adds fare info to the ride details."
    rideDetails [
        ^ super rideDetails,
          ', Fare: $', self calculateFare asString,
          ' (Premium Rate)'
    ]
].

"--------------------------------------------------------------------------
 Driver Class
--------------------------------------------------------------------------"
Object subclass: Driver [
    | driverID name rating assignedRides |

    "Initialize the driver with ID, name, rating, and an empty ride list."
    initializeWithID: anID name: n rating: r [
        driverID := anID.
        name := n.
        rating := r.
        assignedRides := OrderedCollection new
    ]

    "Adds a ride to the driver's list of assigned rides."
    addRide: aRide [
        assignedRides add: aRide
    ]

    "Returns a string with driver info and total rides."
    getDriverInfo [
        ^ 'Driver ID: ', driverID asString,
          ' Name: ', name,
          ' Rating: ', rating asString,
          ' Rides Completed: ', assignedRides size asString
    ]
].

"--------------------------------------------------------------------------
 Rider Class
--------------------------------------------------------------------------"
Object subclass: Rider [
    | riderID name requestedRides |

    "Initialize the rider with ID, name, and an empty list of rides."
    initializeWithID: anID name: n [
        riderID := anID.
        name := n.
        requestedRides := OrderedCollection new
    ]

    "Adds a ride to the rider's list of requested rides."
    requestRide: aRide [
        requestedRides add: aRide
    ]

    "Returns a collection of ride-details strings for each requested ride."
    viewRides [
        ^ requestedRides collect: [:ride | ride rideDetails]
    ]
].

"--------------------------------------------------------------------------
 Test / Demo Section
--------------------------------------------------------------------------
 We define temporary variables inside a block so that they don't remain 
 globally defined in the image after this script runs."
[ 
    | rider1 driver1 ride1 ride2 |

    "Create a Rider (KIRIGAYA) and a Driver (NIHAR)."
    rider1 := Rider new initializeWithID: 1 name: 'KIRIGAYA'.
    driver1 := Driver new initializeWithID: 101 name: 'NIHAR' rating: 4.8.

    "Create two rides: Standard and Premium."
    ride1 := StandardRide new
                initializeWithID: 1001
                pickup: 'Downtown'
                dropoff: 'Airport'
                distance: 10.

    ride2 := PremiumRide new
                initializeWithID: 1002
                pickup: 'Mall'
                dropoff: 'Hotel'
                distance: 5.

    "KIRIGAYA requests both rides."
    rider1 requestRide: ride1.
    rider1 requestRide: ride2.

    "NIHAR is assigned both rides."
    driver1 addRide: ride1.
    driver1 addRide: ride2.

    "Print driver info to Transcript"
    Transcript show: driver1 getDriverInfo; cr.

    "Print each ride's details requested by KIRIGAYA.
     For convenience, we join them with newlines."
    (rider1 viewRides) 
        do: [:details | 
            Transcript show: details; cr
        ].
] value.
