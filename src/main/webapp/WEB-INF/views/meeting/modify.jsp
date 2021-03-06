<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file = "../includes/header.jsp" %>

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset= UTF-8">

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
 <meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>		


<title>Insert title here</title>
<style>

a:link {color: black;}
a:visited{color: black;}
a:hover{color: black;}

.pagination {
  color: black;
  
  padding: 8px 16px;
  text-decoration: none;
}


#map {

	width:500px;
	height:300px;	
       
}


      /* Optional: Makes the sample page fill the window. */


</style>

<script>

$(document).ready(function(){
	
	$('#mname').focus();

	

	$("#mpic").change(function(e){

		if( $("#mpic").val() != "" ){
			
		   	var ext = $('#mpic').val().split('.').pop().toLowerCase();
		  	if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
			     alert('등록 할수 없는 파일명입니다.');
			     $("#mpic").val(""); 
			     return;
		 	}
		  	
		  	
		}
		
		if(document.getElementById("mpic").value!=""){
		    var fileSize = document.getElementById("mpic").files[0].size;
		    var maxSize = 3 * 1024 * 1024;//3MB
		 	 
		    if(fileSize > maxSize){
		       alert("첨부파일 사이즈는 3MB 이내로 등록 가능합니다. ");
		        $("#mpic").val("");
		        return;
		     }
		} 
	});
	
	$('input[type="textbox"]').keydown(function() {
		  if (event.keyCode === 13) {
		    event.preventDefault();
		  };
	});
	
	$('#cancel').click(function(){
		var ask = "작성한 내용을 지우고 목록으로 돌아가시겠습니까?";
		if(confirm(ask)){
			location.href="/meeting/list";
		}
	});
	$('#content').on('keyup', function() {
		if($(this).val().length > 2500) {
			alert("글자수는 2500자로 이내로 제한됩니다.");
			$(this).val($(this).val().substring(0, 2500));
		}
	});
	
	
	
});	

function chkAll(){
	
	
	
	var mname = document.getElementById("mname").value;
	var whichday = $("input[type='checkbox']").is(':checked');
	var chat = document.getElementById("chat").value;
	var content = document.getElementById("content").value;
	var mpic = document.getElementById("mpic").value;
	var lat = document.getElementById("lat").value;
	var lng = document.getElementById("lng").value;
	
	if (mname == null || mname == "") 		{alert("그룹명을 입력하세요"); $('#mname').focus(); return false;}
	if (!whichday) 							{alert("만나는 요일을 선택하세요"); $('#whichday').focus(); return false;}
	if (chat == null || chat == "") 		{alert("오픈채팅방 주소를 입력하세요"); $('#chat').focus(); return false;}
	if (content == null || content == "") 	{alert("그룹 설명을 입력하세요"); $('#content').focus(); return false;}
	if (mpic == null || mpic == "") 		{alert("그룹 대표사진을 첨부하세요"); $('#mpic').focus(); return false;}
	if (lat == null || lat == "") 			{alert("지도에 위치를 지정하세요"); $('#lat').focus(); return false;}
	if (lng == null || lng == "") 			{alert("지도에 위치를 지정하세요"); $('#lng').focus(); return false;}
	
	var chkArray = Array();
	var chkCnt = 0;
	var chkBox = $(".whichday");
	
	for(i=0;i<chkBox.length;i++){
		if(chkBox[i].checked == true){
			chkArray[chkCnt] = chkBox[i].value;
			chkCnt++;
		}
	}
	$("#whatday").val(chkArray);
	
	return true;
	
	
};

function cancel(){
	
	location.href="/meeting/list";
	
	return false;
}



</script>
</head>
<body>

<div  align="center">


	
	<div  style="width:60%;margin-bottom: 5%;">
	<form action="/meeting/modify" name = "isSubmit" method="post" enctype="multipart/form-data" onsubmit="return chkAll()">
	<br><br>
		<h2>그룹 정보 수정</h2>
		<br>
		<table style="width:95%;" class="table table-bordered ">
		<thead class="thead-light" align="center" vertical-align="middle">
			<tr>
				<th  style="vertical-align:middle">그룹명</th>
				<td>
				<input name = "mname" id= "mname" maxlength = "90" value = "${info.mname }" class = "form-control" style="width:78%; float:left;"/>
					<select class="form-control" id="category" name = "category" style="width:120px;height:35px;">
					  	<option value="">-category-</option>
					    <option value="IT과학" <c:if test="${info.category eq 'IT과학' }">selected</c:if>>IT & 과학</option>
					    <option value="운동" <c:if test="${info.category eq '운동' }">selected</c:if>>운동</option>
					    <option value="동물" <c:if test="${info.category eq '동물' }">selected</c:if>>동물</option>
					    <option value="종교" <c:if test="${info.category eq '종교' }">selected</c:if>>종교</option>
					    <option value="음식" <c:if test="${info.category eq '음식' }">selected</c:if>>음식</option>
					    <option value="공연영화" <c:if test="${info.category eq '공연영화' }">selected</c:if>>공연 & 영화</option>
					    <option value="책" <c:if test="${info.category eq '책' }">selected</c:if>>책</option>
					    <option value="비즈니스" <c:if test="${info.category eq '비즈니스' }">selected</c:if>>비즈니스</option>
					    <option value="봉사" <c:if test="${info.category eq '봉사' }">selected</c:if>>봉사</option>
					    <option value="언어" <c:if test="${info.category eq '언어' }">selected</c:if>>언어</option>
					    <option value="예술공예" <c:if test="${info.category eq '예술공예' }">selected</c:if>>예술 & 공예</option>
					    <option value="음악" <c:if test="${info.category eq '음악' }">selected</c:if>>음악</option>
					 </select>
				</td>
			</tr>
			<tr>
		 		<th style="vertical-align:middle">위치</th>
		 		<td>
		 		<div class="form-check-inline">
				  <label class="form-check-label">
				    <input type="radio" value="서울" class="location form-check-input" name="location" <c:if test="${info.location eq '서울' }">checked</c:if>>서울
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input type="radio" value="경기" class="location form-check-input" name="location" <c:if test="${info.location eq '경기' }">checked</c:if>>경기
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input type="radio" value="인천" class="location form-check-input" name="location" <c:if test="${info.location eq '인천' }">checked</c:if>>인천
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input type="radio" value="대전" class="location form-check-input" name="location" <c:if test="${info.location eq '대전' }">checked</c:if>>대전
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input type="radio" value="대구" class="location form-check-input" name="location" <c:if test="${info.location eq '대구' }">checked</c:if>>대구
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input type="radio" value="광주" class="location form-check-input" name="location" <c:if test="${info.location eq '광주' }">checked</c:if>>광주
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input type="radio" value="부산" class="location form-check-input" name="location" <c:if test="${info.location eq '부산' }">checked</c:if>>부산
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input type="radio" value="제주" class="location form-check-input" name="location" <c:if test="${info.location eq '제주' }">checked</c:if>>제주
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input type="radio" value="기타" class="location form-check-input" name="location">기타
				  </label>
				</div>
		 		</td>
		 		
		 	</tr>
			<tr>
				<th style="vertical-align:middle">만나는 요일</th>
				<td>
				
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input name = "whichday" type="checkbox" class="whichday form-check-input" value="Mon" <c:set var ="whatday" value="${info.whatday}"/><c:if test="${fn:contains(whatday, 'Mon') }">checked</c:if>>Mon
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input name = "whichday" type="checkbox" class="whichday form-check-input" value="Tue" <c:set var ="whatday" value="${info.whatday}"/><c:if test="${fn:contains(whatday, 'Tue') }">checked</c:if>>Tue
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input name = "whichday" type="checkbox" class="whichday form-check-input" value="Wed" <c:set var ="whatday" value="${info.whatday}"/><c:if test="${fn:contains(whatday, 'Wed') }">checked</c:if>>Wed
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input name = "whichday" type="checkbox" class="whichday form-check-input" value="Thur" <c:set var ="whatday" value="${info.whatday}"/><c:if test="${fn:contains(whatday, 'Thur') }">checked</c:if>>Thur
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input name = "whichday" type="checkbox" class="whichday form-check-input" value="Fri" <c:set var ="whatday" value="${info.whatday}"/><c:if test="${fn:contains(whatday, 'Fri') }">checked</c:if>>Fri
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input name = "whichday" type="checkbox" class="whichday form-check-input" value="Sat" <c:set var ="whatday" value="${info.whatday}"/><c:if test="${fn:contains(whatday, 'Sat') }">checked</c:if>>Sat
				  </label>
				</div>
				<div class="form-check-inline">
				  <label class="form-check-label">
				    <input name = "whichday" type="checkbox" class="whichday form-check-input" value="Sun" <c:set var ="whatday" value="${info.whatday}"/><c:if test="${fn:contains(whatday, 'Sun') }">checked</c:if>>Sun
				  </label>
				</div>
				<input type="hidden" name = "whatday" id = "whatday" value="" />
				
				</td>
			</tr>
			<tr>
				<th style="vertical-align:middle">카카오톡 openchat URL</th>
				<td>
				<input name = "chat" id="chat" class = "form-control" value = "${info.chat }" maxlength = "100" />
				</td>
			</tr>
		 	<tr>
		 		<th style="vertical-align:middle">그룹 대표 사진</th>
		 		<td>
		 		<input name = "mpic" id="mpic" type="file" class="form-control-file border" style="width:55%;display:inline;float:left;" /><div style="display:inline;float:left;">&nbsp;&nbsp;File: gif, png, jpg, jpeg (size<3MB)</div>
		 		
		 		</td>
		 	</tr>
		 	
		 	<tr>
		 		<th style="vertical-align:middle">상세내용</th>
		 		<td>
			 		<div class="form-group">
					
					<textarea name="content" class="form-control" rows="10" id="content">${info.content }</textarea>
					</div>
		 		</td>
		 	</tr>
		 	<tr>
		 		<th style="vertical-align:middle">상세위치</th>
		 		<td>
			 		<!-- 지도시작 -->
			 		<div id="map"></div>
			 		<div id="floating-panel">
			 			<input type="hidden" />
				      <input id="address" type="textbox" value="Seoul station">
				      <input id="submit" type="button" value="검색">
				    </div>
				    
				    <script>
				      function initMap() {
				        var map = new google.maps.Map(document.getElementById('map'), {
				          zoom: 12,
				          center: {lat: 37.5489539, lng: 126.99402399999997}
				        });
				        var geocoder = new google.maps.Geocoder();
				
				        document.getElementById('submit').addEventListener('click', function() {
				          geocodeAddress(geocoder, map);
				        });
				      }
				
				      function geocodeAddress(geocoder, resultsMap) {
				        var address = document.getElementById('address').value;
				        geocoder.geocode({'address': address}, function(results, status) {
				          if (status === 'OK') {
				        	resultsMap.setCenter(results[0].geometry.location);
				            var marker = new google.maps.Marker({
				              map: resultsMap,				   
				              position: results[0].geometry.location
				              				              
				            });
				            resultsMap.setZoom(13);
				            var lat = marker.getPosition().lat();
				            var lng = marker.getPosition().lng();
				            document.getElementById("lat").value = lat;
				            document.getElementById("lng").value = lng;
				          } else {
				            alert('Geocode was not successful for the following reason: ' + status);
				          }
				        });
				      }
				      
				    </script>
				    <script async defer
				    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD-4J7dCg3e6PgUukJBfpLBpkY9517OQ1I&callback=initMap">
				    </script>
				    
				    <!-- 지도 끝 -->
		 		</td>
		 	</tr>
		 	
		 	</thead>
		</table>
		<div align="center">
		<input type="hidden" name="idValue" value=""/>
		<input type="hidden" name="userid" value="Test" />
		<input type="hidden" id="lat" name = "lat" value=""/>
		<input type="hidden" id="lng" name = "lng" value=""/>
		<input type="hidden" name = "mno" value = "${info.mno }" />
		
		<button type="button" class="btn btn-danger" id="cancel" >취소</button>
		<button id="issubmit" type="submit" class="btn btn-primary" >그룹수정</button>
		</div>
		</form>
   	 </div>
   	 
   	 
   	 
</div>
</body>
<%@ include file = "../includes/footer.jsp" %>
</html>