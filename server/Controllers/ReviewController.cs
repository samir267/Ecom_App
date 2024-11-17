using Microsoft.AspNetCore.Mvc;
using server.Dto;
using server.Models;
using server.Services;

namespace server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReviewController : ControllerBase
    {
        private readonly ReviewService _reviewService;

        public ReviewController(ReviewService reviewService)
        {
            _reviewService = reviewService;
        }

        [HttpPost]
        public async Task<IActionResult> AddReview([FromBody] AddReviewDto reviewDto)
        {
            var review = new ReviewModel
            {
                Content = reviewDto.Content,
                Rating = reviewDto.Rating,
                ProductId = reviewDto.ProductId,
                UserId = reviewDto.UserId
            };

            var addedReview = await _reviewService.AddReviewAsync(review);
            return CreatedAtAction(nameof(GetReviewsByProductId), new { productId = review.ProductId }, addedReview);
        }

        [HttpGet("{productId}")]
        public async Task<ActionResult<IEnumerable<ReviewModel>>> GetReviewsByProductId(int productId)
        {
            var reviews = await _reviewService.GetReviewsByProductIdAsync(productId);
            return Ok(reviews);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteReview(int id)
        {
            var result = await _reviewService.DeleteReviewAsync(id);
            if (!result)
            {
                return NotFound();
            }
            return NoContent();
        }
    }
}
