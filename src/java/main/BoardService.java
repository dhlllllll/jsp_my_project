package sec03.brd01;

import java.util.List;

public class BoardService {
	BoardDAO boardDAO;

	public BoardService() {
		boardDAO = new BoardDAO();
		//������ ȣ�� �� BoardDAO ��ü�� �����Ѵ�. 
	}
	
	public List<ArticleVO> listArticles(){
		List<ArticleVO> articlesList = boardDAO.selectAllArticles();
		return articlesList;
	}
	
	public int addArticle(ArticleVO article) {
		return boardDAO.insertNewArticle(article);
		//�� �� ��ȣ�� ��Ʈ�ѷ��� ��ȯ�Ѵ�. 
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
		//���� �����ϱ� �� �� ��ȣ���� ArrayList ��ü�� �����Ѵ�. 
		boardDAO.deleteArticle(articleNO);
		return articleNOList; //������ �� ��ȣ ����� ��Ʈ�ѷ��� ��ȯ�Ѵ�. 
	}
	
	
	
	
}
