<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="articlesList" value="${articlesMap.articlesList}" />
<c:set var="totArticles" value="${articlesMap.totArticles}" />
<c:set var="section" value="${articlesMap.section }" />
<c:set var="pageNum" value="${articlesMap.pageNum }" />
<!-- HashMap으로 저장해서 넘어온 값들은 이름이 길어 사용하기 불편하므로 c:set태그로 각 값들을 짧은 변수로 저장한다.  -->

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
    .no-uline{text-decoration:none;font-size:20px; color:red;}
	.sel-page{text-decoration:none; color:blue;}
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
			<c:when test="${articlesList == null}">
				<tr height="10">
					<td colspan="4">
						<p align="center">
							<b> <span style="font-size:9pt;">등록된 글이 없습니다.</span></b>
						</p>
					</td>
				</tr>
			</c:when>
			<c:when test="${articlesList != null}">
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
	
	<div class="cls2">
		<c:if test="${totArticles != null}">
			<c:choose>
				<c:when test="${ totArticles > 100 }"><!--전체 글수가 100보다 클때  -->
					<c:forEach var="page" begin="1" end="10" step="1">
						<c:if test="${section > 1 && page == 1 }">
							<a class="no-uline" href = "
													${contextPath}/board/listArticles.do?section
													=${section-1}&pageNum=${(section-1)*10
													+1 }" >&nbsp; pre </a> 
						</c:if>						<!-- section값 2부터는 앞 섹션으로 이동할 수 있는 pre를 표시한다. -->
						<a class="no-uline" href = "
													${contextPath}/board/listArticles.do?section
													=${section}&pageNum=${page}">${(section-1)*10+page}</a>
						<c:if test="${page == 10}">
							<a class="no-uline" href = "
													${contextPath}/board/listArticles.do?section
													=${section+1}&pageNum=${section*10+1}" >&nbsp; next </a>
						</c:if>
					</c:forEach>
				</c:when>
				
				<c:when test="${ totArticles == 100 }"> <!--전체글수가 100개일때는 첫번째 섹션의 10개 페이지만 표시한다 -->
					<c:forEach var="page" begin="1" end="10" step="1">
						<a class="no-uline" href="#">${page}</a>
					</c:forEach>
				</c:when>
				
				<c:when test="${ totArticles < 100 }"><!--전체글수가 100보다 적을때 페이징을 표시한다 -->
				<!--전체글수가 100개가 되지않으므로 표시되는 페이지는 10개가 되지않고 
				전체 글 수를 10으로 나누어 구한 몫에 1을 더한 페이지까지 표시된다. -->
					<c:forEach var="page" begin="1" end="${totArticles/10 + 1}" step="1">
						<c:choose>
							<c:when test="${page==pageNum }">
								<a class="sel-page" href = "
													${contextPath}/board/listArticles.do?section
													=${section}&pageNum=${page}">${page}</a>
							</c:when>
							<c:otherwise>
								<a class="no-uline" href = "
													${contextPath}/board/listArticles.do?section
													=${section}&pageNum=${page}">${page}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
			</c:choose>
		</c:if>
	</div>
	
	<a class="cls1" href="${contextPath}/board/articleForm.do">
		<p class="cls2">글쓰기</p>
	</a>
</body>
</html>