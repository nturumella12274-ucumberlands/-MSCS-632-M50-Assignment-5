#include <iostream>
#include <vector>
using namespace std;

// Base Class: Ride
class Ride {
protected:
    int rideID;
    string pickupLocation, dropoffLocation;
    double distance;
public:
    Ride(int id, string pickup, string dropoff, double dist) 
        : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff), distance(dist) {}
    virtual double calculateFare() = 0;
    virtual void rideDetails() {
        cout << "Ride ID: " << rideID << "\nPickup: " << pickupLocation << "\nDropoff: " << dropoffLocation << "\nDistance: " << distance << " miles\n";
    }
    virtual ~Ride() {}
};

// Derived Class: StandardRide
class StandardRide : public Ride {
public:
    StandardRide(int id, string pickup, string dropoff, double dist) : Ride(id, pickup, dropoff, dist) {}
    double calculateFare() override {
        return distance * 1.5; // $1.5 per mile
    }
    void rideDetails() override {
        Ride::rideDetails();
        cout << "Fare: $" << calculateFare() << " (Standard Rate)\n";
    }
};

// Derived Class: PremiumRide
class PremiumRide : public Ride {
public:
    PremiumRide(int id, string pickup, string dropoff, double dist) : Ride(id, pickup, dropoff, dist) {}
    double calculateFare() override {
        return distance * 3.0; // $3 per mile
    }
    void rideDetails() override {
        Ride::rideDetails();
        cout << "Fare: $" << calculateFare() << " (Premium Rate)\n";
    }
};

// Driver Class
class Driver {
private:
    vector<Ride*> assignedRides;
public:
    int driverID;
    string name;
    double rating;
    Driver(int id, string n, double r) : driverID(id), name(n), rating(r) {}
    void addRide(Ride* ride) {
        assignedRides.push_back(ride);
    }
    void getDriverInfo() {
        cout << "Driver ID: " << driverID << "\nName: " << name << "\nRating: " << rating << "\nRides Completed: " << assignedRides.size() << "\n";
    }
};

// Rider Class
class Rider {
public:
    int riderID;
    string name;
    vector<Ride*> requestedRides;
    Rider(int id, string n) : riderID(id), name(n) {}
    void requestRide(Ride* ride) {
        requestedRides.push_back(ride);
    }
    void viewRides() {
        cout << "Rider: " << name << "'s Ride History:\n";
        for (auto ride : requestedRides) {
            ride->rideDetails();
        }
    }
};

// Main Function
int main() {
    Rider rider1(1, "KIRIGAYA");
    Driver driver1(101, "NIHAR", 4.8);
    
    Ride* ride1 = new StandardRide(1001, "Downtown", "Airport", 10);
    Ride* ride2 = new PremiumRide(1002, "Mall", "Hotel", 5);
    
    rider1.requestRide(ride1);
    rider1.requestRide(ride2);
    driver1.addRide(ride1);
    driver1.addRide(ride2);
    
    cout << "\nDriver Information:\n";
    driver1.getDriverInfo();
    
    cout << "\nRide Details:\n";
    rider1.viewRides();
    
    delete ride1;
    delete ride2;
    return 0;
}
