public class ProductWithReviewsDto
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public decimal Price { get; set; }
    public List<ReviewDto> Reviews { get; set; }
}

public class ReviewDto
{
    public string Content { get; set; }
    public int Rating { get; set; }
}
