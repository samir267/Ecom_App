using Microsoft.EntityFrameworkCore;
using server.models;

namespace server.Models
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        public DbSet<UserModel> Users { get; set; }
        public DbSet<CategoryModel> Categories { get; set; } 
        public DbSet<ProductModel> Products { get; set; }
    }
}
