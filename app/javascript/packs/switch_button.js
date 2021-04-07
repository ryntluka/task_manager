function removeActive() {
    $("#btn1")[0].classList.remove("active")
    $("#btn2")[0].classList.remove("active")
    $("#btn3")[0].classList.remove("active")
}

$(document).ready(() => {
    $("#btn1").on('click', (e) => {
        removeActive()
        e.target.classList.add("active")
        e.preventDefault();
    })
    $("#btn2").on('click', (e) => {
        removeActive()
        e.target.classList.add("active")
        e.preventDefault();
    })
    $("#btn3").on('click', (e) => {
        removeActive()
        e.target.classList.add("active")
        e.preventDefault();
    })
})