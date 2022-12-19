package sec03.brd01;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BoardService {
	BoardDAO boardDAO;

	public BoardService() {
		boardDAO = new BoardDAO();
		//생성자 호출 시 BoardDAO 객체를 생성한다. 
	}
	
	public Map listArticles(Map pagingMap) { //페이징 기능에 필요한 글목록과 전체글 수를 조회한닫. 
		Map articlesMap = new HashMap();
		List<ArticleVO> articlesList = boardDAO.selectAllArticles(pagingMap);
		//전달된 pagingMap을 사용해 글 목록을 조회한다. 
		int totArticles = boardDAO.selectTotArticles();
		//테이블에 존재하는 전체 글 수를 조회한다.
		articlesMap.put("articlesList", articlesList);
		//조회된 글목록을 ArrayList에 저장한후 다시 articlesMap에 저장한다. 
		articlesMap.put("totArticles", 170);
		return articlesMap;
	}
	
	public List<ArticleVO> listArticles(){
		List<ArticleVO> articlesList = boardDAO.selectAllArticles();
		return articlesList;
	}
	
	public int addArticle(ArticleVO article) {
		return boardDAO.insertNewArticle(article);
		//새 글 번호를 컨트롤러로 반환한다. 
	}
	
	public ArticleVO viewArticle(int articleNO) {
		ArticleVO article = null;
		article = boardDAO.selectArticle(articleNO);
		System.out.println(articleNO);
		return article;
	}

	public void modArticle(ArticleVO article) {
		boardDAO.updateArticle(article);		
	}

	public List<Integer> removeArticle(int articleNO) {
		List<Integer> articleNOList = boardDAO.selectRemovedArticles(articleNO);
		//글을 삭제하기 전 글 번호들을 ArrayList 객체에 저장한다. 
		boardDAO.deleteArticle(articleNO);
		return articleNOList; //삭제한 글 번호 목록을 컨트롤러로 반환한다. 
	}

	public int addReply(ArticleVO article) {
		return boardDAO.insertNewArticle(article);
	}
	
	
	
	
}
