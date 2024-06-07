import { dbank_backend } from '../../declarations/dbank_backend';

// Update balance
addEventListener('load', async function () { 
    console.log("finished loading");
    update();
});

// Transaction
document.querySelector("form").addEventListener("submit", async function (event) {
    
    console.log("Submitted.");
    event.preventDefault();

    // Disable the button
    const button = event.target.querySelector("#submit-btn");
    button.setAttribute("disabled", true);

    // topUp
    const inputAmt = parseFloat(document.getElementById("input-amount").value);
    
    // If user has entered an input
    if (document.getElementById("input-amount").value.length != 0)
        await dbank_backend.topUp(inputAmt);
    
    document.getElementById("input-amount").value = "";

    // Withdrawal
    const outputAmt = parseFloat(document.getElementById("withdrawal-amount").value);

    if (document.getElementById("withdrawal-amount").value.length != 0) 
        await dbank_backend.withdraw(outputAmt);
    
    document.getElementById("withdrawal-amount").value = "";

    // Compound
    await dbank_backend.compound();

    update();
    button.removeAttribute("disabled");
});


async function update() {
    const currentAmount = await dbank_backend.checkBalance();
    document.getElementById("value").innerText = currentAmount.toFixed(2);
}
