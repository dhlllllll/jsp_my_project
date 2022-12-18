<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<style>
     .cls1 {
       text-decoration:none;
     }    
     .cls2 {
       font-size:30px;
       text-align:center;
     }
  </style>
<meta charset="UTF-8">
<title>글 목록창</title>
</head>
<body>
	<table align="center" border="1" width="80%">
		<tr height="10" align="center" bgcolor="lightgreen">
			<td>글번호</td>
			<td>작성자</td>
			<td>제목</td>
			<td>작성일</td>
		</tr>
		<c:choose>
			<c:when test="${articlesList ==null}">
				<tr height="10">
					<td colspan="4">
						<p align="center">
							<b> <span style="font-size:9pt;">등록된 글이 없습니다.</span></b>
						</p>
					</td>
				</tr>
			</c:when>
			<c:when test="${articlesList !=null}">
				<c:forEach var="article" items="${articlesList }" varStatus="articleNum">
				<!--articlesList로 포워딩된  글 목록을 forEach태그를 이용해 표시한다.-->
					<tr align="center">
						<td width="5%">${articleNum.count}</td>
						<!-- varStatus의 count 속성을 이용해 글번호를 1부터 자동으로 표시 -->
						<td width="10%">${article.id}</td>
						<td align="left" width="35%">
							<span style="padding-left:30px"></span>
							<!-- 왼쪽으로 30px 여백을 준 후 글 제목을 표시 -->
							<c:choose>
								<c:when test='${article.level > 1 }'>
								<!-- level값이 1보다 큰 경우 자식글이므로 level값만큼 부모 글 밑에 들여쓰기로 자식글임을 표시-->
									<c:forEach begin="1" end="${article.level }" step="1">
										<span style="padding-left:20px"></span><!--자식글 들여쓰기  -->
									</c:forEach>
									<span style="font-size:12px">[답변]</span>
									  <a class='cls1' href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO}">${article.title}</a>
											<!-- 공백 다음에 자식글을 표시한다. -->
								</c:when>
								<c:otherwise>
									<a class='cls1' href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO}">${article.title }</a>
								</c:otherwise>
							</c:choose>
						</td>
						<td width="10%">
							<fmt:formatDate value="${article.writeDate }"/>
						</td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
	<a class="cls1" href="${contextPath}/board/articleForm.do">
		<p class="cls2">글쓰기</p>
	</a>
</body>
</html>