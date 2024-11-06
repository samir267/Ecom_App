using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using server.Models;
using server.Services;
using server.Repositories;  // <-- Ajouter cet import
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Configuration de la chaîne de connexion pour AppDbContext
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// Ajout des services pour le contrôle API
builder.Services.AddControllers();

// Enregistrement de UserRepository et UserService
builder.Services.AddScoped<UserRepository>();  // <-- Enregistrement de UserRepository
builder.Services.AddScoped<UserService>();     // <-- Enregistrement de UserService
builder.Services.AddScoped<CategoryRepository>();  // <-- Enregistrement de UserReposito>
builder.Services.AddScoped<CategoryService>();     // <-- Enregistrement de UserService
builder.Services.AddScoped<ProductRepository>();  // <-- Enregistrement de Us
builder.Services.AddScoped<ProductService>();    

// Configuration de l'authentification JWT
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(options =>
{
    options.RequireHttpsMetadata = false;
    options.SaveToken = true;
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = builder.Configuration["Jwt:Issuer"],
        ValidAudience = builder.Configuration["Jwt:Audience"],
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]))
    };
});

// Ajouter Swagger/OpenAPI pour la documentation d'API
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Construction de l'application
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

// Utilisation de l'authentification et de l'autorisation
app.UseAuthentication();
app.UseAuthorization();

// Mapping des routes des contrôleurs
app.MapControllers();

app.Run();
