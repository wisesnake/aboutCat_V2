// 팝업 띄우기
window.onload = function () {
  if (getCookie("noShowPopup")) {
    return;
  }
  document.getElementById("popupContainer").style.display = "block";
};

// 팝업 닫기
function closePopup() {
  var checkbox = document.getElementById("noShow");
  if (checkbox.checked) {
    setCookie("noShowPopup", "true", 1); // 쿠키 설정 (하루 동안 유지)
  }
  document.getElementById("popupContainer").style.display = "none";
}

// 쿠키 설정 함수
function setCookie(name, value, days) {
  var expires = "";
  if (days) {
    var date = new Date();
    date.setTime(date.getTime() + days * 24 * 60 * 60 * 1000);
    expires = "; expires=" + date.toUTCString();
  }
  document.cookie = name + "=" + (value || "") + expires + "; path=/";
}

// 쿠키 가져오기 함수
function getCookie(name) {
  var nameEQ = name + "=";
  var ca = document.cookie.split(";");
  for (var i = 0; i < ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) == " ") {
      c = c.substring(1, c.length);
    }
    if (c.indexOf(nameEQ) == 0) {
      return c.substring(nameEQ.length, c.length);
    }
  }
  return null;
}