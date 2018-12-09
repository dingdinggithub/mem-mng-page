var currentPath = window.document.location.href;
var pathName = window.document.location.pathname;
var pos = currentPath.indexOf(pathName);
var serverPath = currentPath.substring(0, pos);
var projectName = pathName
		.substring(0, pathName.substr(1).indexOf('/') + 1);
var realPath = serverPath + projectName;

function toSubmit(formId){
	var form = document.getElementById(formId);
	form.submit();
}

