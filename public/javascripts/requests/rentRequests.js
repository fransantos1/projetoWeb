async function CreateRent(beginning, end,car_id) {
    try {
        const response = await fetch(`/api/rent/auth`, 
        {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
          method: "POST",
          body: JSON.stringify({
              beginning: beginning,
              end: end,
              car:car_id
          })
        });
        // We are not checking for errors (considering the GUI is only allowing correct choices)
        // We only need to send if the user registered or not 
        return { successful: response.status == 200};
    } catch (err) {
        // Treat 500 errors here
        console.log(err);
        return {err: err};
    }
}
async function requestRentCourse(rentid, day) {
    try {
        const response = await fetch(`/api/rent/auth/getCourse/${rentid}/${day}`);
        console.log(response);
        if (response.status == 204) 
        return { successful: response.status == 200,
                result: "no content"}

        var result = await response.json();       
        return { successful: response.status == 200,
                 result: result};
    } catch (err) {
        console.log(err);
        return {err: err};
    }
}



async function verifyRent(rentid){
    try {
        const response = await fetch(`/api/rent/auth/verify`,{
            method: 'PATCH',
            body: JSON.stringify({
                rentid: rentid,
              }),
            headers: {
              'Content-type': 'application/json; charset=UTF-8',
            },})
        var result = await response.json();
        
        
    return { successful: response.status == 200,
                 rents: result};
    } catch (err) {
        console.log(err);
        return {err: err};
    }
}
async function requestRentsHistoryFromUser() {
    try {
        const response = await fetch(`/api/rent/auth/history/fromUser/`);
        var result = await response.json();
        return { successful: response.status == 200,
                 rents: result};
    } catch (err) {
        console.log(err);
        return {err: err};
    }
}
async function requestRentsHistoryFromCar(carid) {
    try {
        const response = await fetch(`/api/rent/auth/history/fromCar/${carid}`);
        var result = await response.json();
        return { successful: response.status == 200,
                 rents: result};
    } catch (err) {
        console.log(err);
        return {err: err};
    }
}
async function requestRentsFromCar(carid) {
    try {
        const response = await fetch(`/api/rent/auth/scheduled/fromCar/${carid}`);
        var result = await response.json();
        return { successful: response.status == 200,
                 rents: result};
    } catch (err) {
        console.log(err);
        return {err: err};
    }
}
async function getScheduledRent() {
    try {
        const response = await fetch(`/api/rent/auth/getScheduled/`);
        var result = await response.json();
        return { successful: response.status == 200,
                 rents: result};
    } catch (err) {
        console.log(err);
        return {err: err};
    }
}

async function deleteRent(rentid) {
    try {
        const response = await fetch(`/api/rent/auth/delete/`,
        {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
          method: "DELETE",
          body: JSON.stringify({
              rentid: rentid
          })
        });
        let msg = await response.json();
        return { successful: response.status == 200, msg: msg.msg};
    } catch (err) {
        console.log(err);
        return {err: err};
    }
}