namespace server.Dto
{
    public class AddReviewDto
    {
        public string Content { get; set; }
        public int Rating { get; set; }
        public int ProductId { get; set; }
        public int UserId { get; set; }
    }
}
