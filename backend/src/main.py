from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import os
import subprocess

app = FastAPI()

class Domain(BaseModel):
    name: str
    admin_email: str

@app.post("/domains/")
async def add_domain(domain: Domain):
    try:
        # Domain yapılandırması
        configure_postfix(domain.name)
        configure_dovecot(domain.name)
        generate_dkim_keys(domain.name)
        
        # Let's Encrypt sertifikası al
        await get_ssl_certificate(domain.name)
        
        return {"status": "success", "message": f"Domain {domain.name} configured successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/domains/{domain_name}/status")
async def get_domain_status(domain_name: str):
    # Domain durumunu kontrol et
    return {
        "domain": domain_name,
        "ssl_valid": check_ssl_status(domain_name),
        "mx_records": check_mx_records(domain_name),
        "dkim_status": check_dkim_status(domain_name)
    } 