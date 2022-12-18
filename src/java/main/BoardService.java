package sec03.brd01;

import java.util.List;

public class BoardService {
	BoardDAO boardDAO;

	public BoardService() {
		boardDAO = new BoardDAO();
		//생성자 호출 시 BoardDAO 객체를 생성한다. 
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
	
	
	
	
}
